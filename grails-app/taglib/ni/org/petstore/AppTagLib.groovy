package ni.org.petstore

class AppTagLib {
  static defaultEncodeAs = 'html'
  //static encodeAsForTags = [tagName: 'raw']

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

	def showProductPresentations = { attrs, body ->
		//Integer productId = attrs.int("productId")
		//Integer
		println params 
	}
}
