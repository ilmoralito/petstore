package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class PresentationController {
	static defaultAction = "save"
	static allowedMethods = [
		save:"POST",
    delete:"GET"
	]

  def save(Integer id, Integer providerId) {
  	def presentation = new Presentation(params)
    def product = Product.get(id)

    if (!product) {
      response.sendError 404
    }

    product.addToPresentations presentation

    if (!presentation.save()) {
      presentation.errors.allErrors.each { println it }
    }

    flash.message = (!presentation.save()) ? "A ocurrido un error. Intentalo otravez" : "Presentacion agregado"
    redirect controller:"product", action:"list", params:[id:id, providerId:providerId]
  }

  def delete(Integer id, Integer productId, Integer providerId) {
    def presentation = Presentation.get(id)

    if (!presentation) {
      response.sendError 404
    }

    def product = Product.get(productId)

    if (product) {
      presentation.delete()
      product.removeFromPresentations presentation
    }

    redirect controller:"product", action:"list", params:[id:productId, providerId:providerId]
  }
}
