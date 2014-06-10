package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class SaleController {
	def presentationService

	static defaultAction = "buildSale"
	static allowedMethods = [
		list:["GET", "POST"],
    detail:"GET",
		buildSale:["GET", "POST"]
	]

	def list() {
    if (request.method == "POST") {
      def client = Client.get(params.int("client"))

      if (!client) {
        response.sendError 404
      }

      def query = Sale.where {
        client == client && status == params.boolean("status")
      }

      //todo:find a better way to do this
      return [clients:Client.list(), sales:query.list()]
    }

    [clients:Client.list()]
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
        flow.sales = [] as List

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

        [product:product, presentations:product.presentations]
      }.to "addPresentation"

      on("pay") { PaymentCommand cmd ->
        if (cmd.hasErrors()) {
          return error()
        }

        def totalToPay = flow.sales.total.sum()

        if (cmd.payment <= totalToPay) {
          //insert new sale
          def sale = new Sale(client:flow.client, status:cmd.payment == totalToPay ? true : false)

          if (!sale.save()) {
            flash.message = "A ocurrido un error"
            return error()
          }

          //add items to new sale
          flow.sales.each {
            def item = new Item(
              product:it.product,
              presentation:it.presentation,
              quantity:it.quantity,
              total:it.total
            )

            sale.addToItems item

            if (!item.save()) {
              flash.message = "A ocurrido un error"
              return error()
            }
          }

          //add payment
          def payment = new Payment(payment:cmd.payment)

          sale.addToPayments payment

          if (!payment.save()) {
            flash.message = "A ocurrido un error"
            return error()
          }

        } else {
          return error()
        }
      }.to "done"

      on("cancel").to "done"
    }

    addPresentation {
      on("confirm"){
        def presentation = Presentation.get(params?.presentation)

        [presentation:presentation, measures:presentation.details.measure]
      }.to "addMeasure"

      on("cancel").to "addProduct"
    }

    addMeasure {
      on("confirm") {
        def q1 = Detail.where {
          presentation { presentation == flow.presentation.presentation } && measure == params?.measure
        }

        def q2 = q1.where {
          presentation.product.name == flow.product.name
        }

        def detail = q2.find()
        def target = flow.sales.find { it.product == flow.product && it.presentation == flow.presentation && it.measure == params?.measure }
        def quantity = target ? detail.quantity - target.quantity.toInteger() : null

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

          flow.sales.add(session.sale)
        }

        [saleDetail:flow.sales.groupBy(){ it.product }]
      }.to "addProduct"

      on("deleteDetail") {
        def target = flow.sales.find { 
          it.product.name == params.product && it.presentation.presentation == params.presentation && it.measure == params.measure
        }
        
        flow.sales -= target

        //this fix the problem but i do not like the solution
        [saleDetail:flow.sales.groupBy(){ it.product }]
      }.to "addQuantity"

      on("cancel").to "addMeasure"
    }

    done() {
      redirect action:"buildSale"
    }
  }
}


class PaymentCommand {
  BigDecimal payment

  static constraints = {
    payment nullable:false, min:0.1
  }
}

class AddQuantityCommand {
  Integer quantity

  static constraints = {
    quantity min:1, nullable:false
  }
}