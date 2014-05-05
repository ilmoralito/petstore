package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class ProductController {
	static defaultAction = "list"
	static allowedMethods = [
		list:"GET",
    show:"GET",
    delete:"GET",
    edit:"GET",
    update:"POST",
    save:"POST"
	]

  def list(Integer providerId) {
  	def provider = Provider.get(providerId)

  	if (!provider) { response.sendError 404 }

  	def products = Product.findAllByProvider(provider)

  	[products:products, provider:provider]
  }

  def show(Integer id) {
    def product = Product.get(id)

    if (!product) { response.sendError 404 }

    [product:product]
  }

  def delete(Integer id) {
    def product = Product.get(id)

    if (!product) { response.sendError 404 }

    product.delete()
    redirect action:"list", params:[providerId:product.provider.id]
  }

  def edit(Integer id) {
    def product = Product.get(id)

    if (!product) {
      response.sendError 404
    }

    [product:product]
  }

  def update(Integer id, Integer providerId) {
    def product = Product.get(id)
    if (!product) { response.sendError 404 }

    def provider = Provider.get(providerId)
    if (!provider) { response.sendError 404 }

    product.properties = params

    flash.message = (!product.save()) ? "A ocurrido un error" : "Actualizado correctamente"
    redirect action:"edit", params:[id:id, providerId:providerId]
  }

  def save(Integer providerId) {
    def product = new Product(params)
    def provider = Provider.get(providerId)

    if (!provider) {
      response.sendError 404
    }

    provider.addToProducts product

    flash.message = (!product.save()) ? "A ocurrido un error. Intentalo de nuevo" : "Hecho"
    redirect action:"list", params:[providerId:providerId]
  }
}
