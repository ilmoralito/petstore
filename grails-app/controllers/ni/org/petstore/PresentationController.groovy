package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class PresentationController {
	static defaultAction = "update"
	static allowedMethods = [
		update:"POST"
	]

  def update(Integer id, Integer providerId, String pres) {
  	def product = Product.get(id)
  	if (!product) { response.sendError 404 }

  	def presentation = Presentation.findByProductAndPresentation(product, pres)

  	println "hello world"

  	if (!presentation) { response.sendError 404 }

  	//presentation.properties["quantity"] = params?.quantity

  	redirect controller:"product", action:"show", params:[providerId:providerId]
  }
}
