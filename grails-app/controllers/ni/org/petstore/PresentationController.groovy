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

      on("listProducts").to "done"
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

      on("editPresentationDetail") {
        def detail = Detail.get(params.int("id"))

        if (!detail) {
          response.sendError 404
        }

        [detail:detail, flag:true]
      }.to "editPresentationDetail"

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

    editPresentationDetail {
      on("confirm") { DetailCommand cmd ->
        if (!cmd.validate()) {
          error()
          return
        }

        flow.detail.properties["quantity", "price"] = params

        if (!flow.detail.save()) {
          flash.message = "A ocurrido un error. Porfavor intentalo otravez"
        }
      }.to "editPresentationDetail"

      on("goBackToAdminPresentationDetail"){
        flow.flag = !flow.flag
        flow.detail = [:]
      }.to "adminPresentationsDetail"
    }

    done() {
      redirect controller:"product", action:"list", params:[providerId:flow.provider.id]
    }
  }

}

class DetailCommand {
  String measure
  Integer quantity
  BigDecimal price

  static constraints = {
    importFrom Detail
  }
}
