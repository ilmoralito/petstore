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

	def list(FilterSaleCommand cmd) {
      def from = params.date("from", "yyyy-MM-dd")
      def to = params.date("to", "yyyy-MM-dd")

      if (request.method == "POST" || from || to) {
        if (cmd.hasErrors()) {
          cmd.errors.allErrors.each { println it }
          flash.message = "Los datos de fecha son necesarios para continuar"
          return
        }

        [sales:Sale.requestFromTo(from, to).list().unique { it.client }]
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
				flow.items = [:]
   			session.itemsCollection = []

				[clients:Client.list()]
			}
			on("success").to "addClient"
			on(Exception).to "done"
		}

		addClient {
			on("confirm") {
				def client = Client.get(params.int("clientId"))
				def products = Product.findAll { presentations.size() > 0 && presentations.quantity > 0 }

				[client:client, products:products]
			}.to "addProduct"
		}

   	addProduct {
   		on("confirm") {
   			def product = Product.get(params.int("productId"))
   			def presentations = product.presentations.findAll { it.quantity > 0 }

   			[presentations:presentations, product:product]
   		}.to "addPresentation"
   		on("cancel") {
        if (session.itemsCollection) {
          if (presentationService.rollingBackPresentationQuantity(session.itemsCollection)) {
            flash.message = "Se deshizo la venta"
          }
        }
      }.to "done"
   		on("removeItem").to "removeItem"
   		on("confirmSale").to "confirmSale"
   	}

   	addPresentation {
   		on("confirm") {
   			def presentation = Presentation.get(params.int("presentationId"))

   			[presentation:presentation]
   		}.to "addQuantity"
   		on("cancel").to "addProduct"
   		on("removeItem").to "removeItem"
   	}

   	addQuantity {
   		on("confirm") { AddQuantityCommand cmd ->
   			def quantity = cmd.quantity

   			//validate inputs
   			if (!cmd.validate()) { 
   				return
   			}

   			//validate presentation quantity
   			if (quantity > presentationService.getQuantity(flow.product, flow.presentation)) {
   				return
   			}

   			//update product presentation quantity
   			flow.presentation.quantity = flow.presentation.quantity - quantity
   			!flow.presentation.save(flush:true) ? error() : success()

   			//add flow instance to items
   			flow.items.put("product", flow.product)
   			flow.items.put("presentation", flow.presentation)
   			flow.items.put("quantity", quantity)
   			flow.items.put("total", quantity * flow.presentation.price)

   			//add new items map to itemsColl
   			session.itemsCollection.add(flow.items)

            //overwrites flow.products variable with products with presentations
            //this is done in addClient action state but need to be call it here, just after adding a new item
            flow.products = Product.findAll { presentations.size() > 0 && presentations.quantity > 0 }
   		}.to "addProduct"
   		on("cancel").to "addPresentation"
   		on("removeItem").to "removeItem"
   	}

   	removeItem {
   		action {
   			Integer index = params.int("index")
   			def element = session.itemsCollection.get index
   			def product = Product.findByName(element.product)
   			def presentation = Presentation.findByPresentation(element.presentation)
   			def targetPresentation = Presentation.findByProductAndPresentation(product, presentation)

   			targetPresentation.quantity = targetPresentation.quantity + element.quantity.toInteger()
   			
   			!targetPresentation.save() ? error() : success()

   			session.itemsCollection.remove index
   		}
   		on("success").to "addProduct"
   		on("error").to "addProduct"
   	}

   	confirmSale {
   		action {
   			//create new sale
   			def sale = new Sale(client:flow.client)
   			if (!sale.save()) {
          sale.errors.allErrors.each {
            println it
          }
   				return
   			}

   			//add items
   			//use transactions here
   			session.itemsCollection.each {
   				def item = new Item(product:it.product, presentation:it.presentation, quantity:it.quantity, total:it.total)

          sale.addToItems(item)

   				if (!item.save()) {
            sale.errors.allErrors.each {
              println it
            }
   					return
   				}
   			}
   		}
   		on("success").to "done"
   		on(Exception).to "addProduct"
   	}

		done() {
			redirect action:"buildSale"
		}
	}
}

@grails.validation.Validateable
class AddQuantityCommand implements Serializable {
  Integer quantity

  static constraints = {
    quantity min:1, blank:false
  }
}

@grails.validation.Validateable
class FilterSaleCommand {
  String from
  String to

  static constraints = {
    from blank:false
    to blank:false
  }
}
