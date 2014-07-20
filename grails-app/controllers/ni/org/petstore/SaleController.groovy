package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class SaleController {
	def presentationService

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

    if (request.method == "POST" || (params.status && params.clientId)) {
      def client = Client.get(params.int("clientId"))

      if (!client) { response.sendError 404 }

      def query = Sale.where {
        client == client && status == params.boolean("status")
      }

      return [clients:clients, sales:query.list(sort:"dateCreated", order:"desc")]
    }

    [clients:clients]
	}

  def pay(Integer clientId, Integer saleId ,Boolean status, PayCommand cmd) {
    if (cmd.hasErrors()) {
      cmd.errors.allErrors.each { println it }
    } else {
      def sale = Sale.get(saleId)

      if (!sale) { response.sendError 404 }

      def paidUp = sale?.payments?.payment?.sum() ?: 0
      def debt = sale.items.total.sum() - paidUp

      if (cmd.payment <= debt) {
        if (cmd.payment == debt) {
          sale.status = true
        }

        def payment = new Payment(payment:cmd.payment, receipt:cmd.receipt)

        sale.addToPayments payment

        if (!sale.save()) {
          sale.errors.allErrors.each { println it }
          redirect action:"list"
        }
      }
    }

    redirect action:"list", params:[status:status, clientId:clientId]
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

  def deletePayment(Integer paymentId, Integer saleId) {
    def sale = Sale.get saleId
    def payment = Payment.get paymentId

    if (!sale || !payment) { response sendError 404 }

    if (sale.payments.size() > 1) {
      sale.removeFromPayments payment
    
      if (payment.delete()) { payment.errors.allErrors.each { println it.defaultMessage } }

      flash.message = "Abono eliminado"
    } else {
      flash.message = "No se puede eliminar el abono, debido a que solo hay uno"
    }

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

  static constraints = {
    importFrom Payment
  }
}