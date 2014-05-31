package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class PresentationController {
	static defaultAction = "list"
	static allowedMethods = [
		save:"POST",
    delete:"GET",
    edit:"GET",
    update:"POST"
	]

  def presentationsFlow = {
    init {
      action {
        def product = Product.load(params?.id)

        if (!product) {
          response.sendError 404
        }

        [product:product, provider:product.provider]
      }
      on("success").to "adminPresentations"
      on("error").to "done"
    }

    adminPresentations {
      on("confirm") {
        def presentations = params.list("presentations")

        if (presentations) {
          presentations.each { presentation ->
            def newPresentation = new Presentation(presentation:presentation)

            flow.product.addToPresentations newPresentation
            newPresentation.save()
          }
        }
      }.to "adminPresentationsDetail"
    }

    adminPresentationsDetail {
      on("confirm") { DetailCommand cmd ->
        if (!cmd.validate()) {
          error()
          return
        }

        def presentation = Presentation.findByProductAndPresentation(flow.product, params?.presentation)
        def presentationDetail = new Detail(measure:cmd?.measure, quantity:cmd?.quantity, price:cmd?.price)

        presentation.addToDetails presentationDetail
        presentationDetail.save()
      }.to "adminPresentationsDetail"

      on("deletePresentation") {
        def presentation = Presentation.findByProductAndPresentation(flow.product, params?.presentation)

        if (presentation) {
          flow.product.removeFromPresentations presentation
          presentation.delete(flush:true)
        }
      }.to "adminPresentationsDetail"

      on("deleteDetail") {
        def presentation = Presentation.findByProductAndPresentation(flow.product, params?.presentation)
        def detail = Detail.get(params?.id)

        presentation.removeFromDetails detail
        detail.delete(flush:true)
      }.to "adminPresentationsDetail"

      on("goBackToAdminPresentation").to "adminPresentations"
    }

    done() {
      redirect action:"presentations"
    }
  }

  /*
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

  def edit(Integer id, Integer productId, Integer providerId) {
    def presentation = Presentation.get(id)

    if (!presentation) {
      response.sendError 404
    }

    [presentation:presentation]
  }

  def update(Integer id, Integer productId, Integer providerId) {
    def presentation = Presentation.get(id)

    if (!presentation) {
      response.sendError 404
    }

    presentation.properties["price", "quantity"] = params

    flash.message = (!presentation.save()) ? "A ocurrido un error. Intentalo otravez" : "Actualizado correctamente"
    redirect controller:"product", action:"list", params:[id:productId, providerId:providerId]
  }
  */

}

class DetailCommand {
  String measure
  Integer quantity
  BigDecimal price

  static constraints = {
    importFrom Detail
  }
}
