package ni.org.petstore

class AppFilters {
  def presentationService

  def filters = {
    all(controller:"*", action:"*") {
      before = {
        if (actionName != "buildSale" && session.itemsCollection) {
          if (presentationService.rollingBackPresentationQuantity(session.itemsCollection)) {
            flash.message = "Se deshizo la venta"
          }
        }
      }
    }
  }
}
