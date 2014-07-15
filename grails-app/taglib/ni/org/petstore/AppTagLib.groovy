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

	def productInStock = {
		def details = Detail.findAllByQuantityLessThan(10)

    if (details && actionName != "buildSale" && actionName != "presentations") {
    	def detailsGroupedByPresentation = details.groupBy() { it.presentation }
			def results = detailsGroupedByPresentation.keySet().groupBy() { it.product }

	   	out << render(template: "/layouts/inStock", model:[results:results])
    }
	}

	def saleStatus = { attrs ->
		def status = attrs.boolean("status")

		if (status) {
			out << "Cancelado"
		} else {
			out << "Credito"
		}
	}
}
