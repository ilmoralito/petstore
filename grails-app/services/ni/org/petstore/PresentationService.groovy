package ni.org.petstore

import grails.transaction.Transactional

@Transactional
class PresentationService {

  def getQuantity(Product product, Presentation present) {
  	def presentation = Presentation.findByProductAndPresentation(product, present)

  	presentation.quantity
  }

  def rollingBackPresentationQuantity(List itemsCollection) {
    itemsCollection.each { item ->
      def presentation = Presentation.findByProductAndPresentation(item.product, item.presentation)

      if (presentation) {
        presentation.quantity = presentation.quantity + item.quantity

        if (!presentation.save()) {
          println "Error trying to rollback items quantities"
        }
      }
    }

    true
  }
}
