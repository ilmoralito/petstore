package ni.org.petstore

class AppTagLib {
  static defaultEncodeAs = "html"
  static encodeAsForTags = [productInStock: "raw"]

  static namespace = "ps"

	def showPrice = { attrs, body ->
		Product product = attrs.product
		def presentation = attrs.presentation

		product.presentations.each {
			if (it.presentation == presentation) {
				out << it.quantity
			}
		}
	}

	//TODO:find a better way to do this
	def itemsQuantity = { attrs, body ->
		def result = 0
		def items = (session?.itemsCollection) ?: attrs.items

		if (items) {
			items.each { item -> result += item.quantity }
		}

		out << result
	}

	//TODO:find a better way to do this
	def itemsTotal = { attrs, body ->
		def result = 0
		def items = (session?.itemsCollection) ?: attrs.items

		if (items) {
			items.each { item -> result += item.total }
		}

		out << result
	}

	def productInStock = { attrs, body ->
		def presentations = Presentation.findAllByQuantityLessThan(10)
        
    if (presentations && controllerName != "sale") {
    	def presentationsGroupedByProduct = presentations.groupBy() { it.product }
    	out << render(template: "/layouts/inStock", model:[presentationsGroupedByProduct:presentationsGroupedByProduct])
    }
	}
}
