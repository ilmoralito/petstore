package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class SaleController {
	def presentationService
  def grailsApplication

	static defaultAction = "buildSale"
	static allowedMethods = [
		list:["GET", "POST"],
    pay:"POST",
    detail:"GET",
		buildSale:["GET", "POST"],
    show:"GET",
    changeSaleStatus:"GET"
	]

	def list() {
    def criteria = Sale.createCriteria()
    def clients = criteria.list {
      projections {
        distinct "client"
      }
    }

    if (request.method == "POST" || (params?.status && params?.clientId)) {
      def client = Client.get(params.int("clientId"))

      if (!client) { response.sendError 404 }

      def query = Sale.where {
        client == client && status == params.boolean("status")
      }

      return [clients:clients, sales:query.list(sort:"dateCreated", order:"desc")]
    }

    [clients:clients]
	}

  def paymentFlow = {
    init {
      action {
        Sale sale = Sale.get(params.int("saleId"))
        
        if (!sale) { response.sendError 404 }

        [sale:sale, checks:[], bancs:grailsApplication.config.ni.org.petstore.bancs]
      }

      on("success").to "receipt"
    }

    receipt {
      on("confirm") { PayCommand cmd ->
        if (cmd.hasErrors()) { return error() }
       
        def payment = cmd.payment ?: 0
        def discount = cmd.discount ?: 0
        def checksValuesTotal = flow?.checks?.checkValue?.sum() ?: 0
        def total = payment + checksValuesTotal
        def totalPaid = total - (total * (discount / 100))

        if (totalPaid <= flow.sale.balance) {
          def paymentInstance = new Payment(payment:payment, receipt:cmd.receipt, discount:discount)
          
          //add checks to payments
          if (flow?.checks) {
            flow.checks.each { check ->
              paymentInstance.addToChecks check
            }
          }

          flow.sale.addToPayments paymentInstance

          //remove all check in checks list
          flow.checks = []

          //update sale balance
          flow.sale.balance -= totalPaid
          
          if (!flow.sale.save(flush:true)) {
            flow.sale.errors.allErrors.each { println it }
          }
        } else {
          flash.message = "El abono es mayor que el saldo"
        }
      }.to "receipt"

      on("addCheck") { CheckCommand cmd ->
        if (cmd.hasErrors()) { return error() }
        def check = new Check(checkNumber:cmd.checkNumber, banc:cmd.banc, checkValue:cmd.checkValue)

        flow.checks << check
        flow.bancs -= cmd.banc
      }.to "receipt"

      on("deleteCheck") {
        Integer index = params.int("index")

        //restore banc to bancs list
        flow.bancs << flow.checks[index].banc
        flow.checks -= flow.checks[index]
      }.to "receipt"
    }

    done() {
      redirect action:"list", params:[status:flow.sale.status, clientId:flow.sale.client.id]
    }
  }

  def detail(Integer clientId) {
    def client = Client.get(clientId)
    def from = params.date("from", "yyyy-MM-dd")
    def to = params.date("to", "yyyy-MM-dd")

    if (!client) {
      response.sendError 404
    }

    def criteria = Item.createCriteria()
    def items = criteria.list {
      sale {
        eq "client", client

        ge "dateCreated", from
        le "dateCreated", to
      }
    }

    [items:items, client:client, itemsByProduct:items.groupBy(){ it.product }]
  }

	def buildSaleFlow = {
    init {
      action {
        def clients = Client.list()
        session.sale = [:]
        flow.sales = []

        [clients:clients]
      }

      on("success").to "selectClient"
    }

    selectClient {
      on("confirm") {
        def client = Client.get(params?.client)
        def products = Product.where {
          presentations.size() > 0
        }

        [client:client, products:products.list()]
      }.to "addProduct"
    }

    addProduct {
      on("confirm") {
        def product = Product.get(params?.product)
        def presentations = Presentation.where {
          product == product && details.quantity > 0
        }

        //state
        flow.state = false

        [product:product, presentations:presentations.list()]
      }.to "addPresentation"

      on("pay") { PaymentCommand cmd ->
        if (cmd.hasErrors()) { return error() }

        def sale = new Sale(invoice:cmd.invoice, client:flow.client, status:cmd.status)

        flow.sales.each {
          def item = new Item(
            product:it.product,
            presentation:it.presentation,
            measure:it.measure,
            quantity:it.quantity,
            total:it.total
          )

          sale.addToItems item
        }
        
        if (!sale.save()) { return error() }

        //update product detail
        flow.sales.each {
          it.detail.quantity = it.detail.quantity.toInteger() - it.quantity.toInteger()
          
          if (!it.detail.save()) {
            it.detail.errors.allErrors.each { println it }  
          }
        }
      }.to "done"

      on("deleteDetail") {
        def target = flow.sales.find { 
          it.product.name == params.product && it.presentation.presentation == params.presentation && it.measure == params.measure
        }
        
        flow.sales -= target

        //this fix the problem but i do not like the solution
        [saleDetail:flow.sales.groupBy(){ it.product }]
      }.to "addProduct"

      on("cancel").to "done"
    }

    addPresentation {
      on("confirm") {
        def presentation = Presentation.get(params?.presentation)

        if (!presentation) {
          return error()
        }

        flow.state = false

        [presentation:presentation, measures:presentation.details.findAll { it.quantity > 0 }.measure]
      }.to "addMeasure"

      on("cancel") {
        flow.state = true
      }.to "addProduct"
    }

    addMeasure {
      on("confirm") {
        def detail = Detail.findByPresentationAndMeasure(flow.presentation, params?.measure)

        def target = flow.sales.find { it.product == flow.product && it.presentation == flow.presentation && it.measure == params?.measure }
        def quantity = target ? detail.quantity - target.quantity.toInteger() : detail.quantity

        [detail:detail, quantity:quantity]
      }.to "addQuantity"

      on("cancel").to "addPresentation"
    }

    addQuantity {
      on("confirm") { AddQuantityCommand cmd ->
        if (cmd.hasErrors()) {
          cmd.errors.allErrors.each { println it.defaultMessage }
          return error()
        }

        def target = flow.sales.find { it.product == flow.product && it.presentation == flow.presentation && it.measure == flow.detail.measure }

        //check if quantity is greater than current product/presentation/measure quantity
        if (target) {
          if (cmd.quantity > (flow.detail.quantity -  target.quantity.toInteger())) {
            return error()
          }
        }

        if (target) {
          target.quantity = target.quantity.toInteger() + params?.quantity?.toInteger()
          target.total = flow.detail.price * target.quantity.toInteger()
        } else {
          session.sale["product"] = flow.product
          session.sale["presentation"] = flow.presentation
          session.sale["measure"] = flow.detail.measure
          session.sale["quantity"] = params?.quantity
          session.sale["total"] = flow.detail.price * params.int("quantity")
          session.sale["detail"] = flow.detail

          flow.sales.add(session.sale)
        }

        flow.state = true

        [saleDetail:flow.sales.groupBy(){ it.product }]
      }.to "addProduct"

      on("cancel") {
        flow.state == false
      }.to "addMeasure"
    }

    done() {
      redirect action:"buildSale"
    }
  }

  def deletePayment(Integer id) {
    def payment = Payment.get id

    if (!payment) { response sendError 404 }

    def sale = payment.sale

    //remove payment from sale
    sale.removeFromPayments payment
  
    //confirm delete payment
    if (!payment.delete()) {
      payment.errors.allErrors.each { println it.defaultMessage }
    }

    //update sale balance -> balance + payment (total) <- cash + checks.checksValue.sum() ?: 0
    sale.balance += payment.getTotalPaid()
    sale.save()

    flash.message = "Abono eliminado"
    redirect action:"list", params:[status:false, clientId:sale.client.id]
  }

  def show(Integer id) {
    def sale = Sale.get(id)

    if (!sale) { response.sendError 404 }

    [sale:sale]
  }

  def changeSaleStatus(Integer id) {
    def sale = Sale.get(id)

    if (!sale) { response.sendError 404 }

    if (!sale.payments) {
      sale.status = !sale.status
    } else {
      flash.message = "Accion no permitida porque ya existen abonos en esta cuenta"
    }

    redirect action:"show", id:id
  }
}


class PaymentCommand {
  Boolean status
  String invoice

  static constraints = {
    importFrom Sale
  }
}

class AddQuantityCommand {
  Integer quantity

  static constraints = {
    quantity min:1, nullable:false
  }
}

class PayCommand {
  String receipt
  BigDecimal payment
  Integer discount
  List checks

  static constraints = {
    importFrom Payment
  }
}

class CheckCommand {
  String checkNumber
  String banc
  BigDecimal checkValue

  static constraints = {
    importFrom Check
  }
}
