package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class PaymentController {

		static defaultAction = "show"
		static allowedMethods = [
			show:"GET",
			delete:"GET"
		]

    def show(Long id) {
    	def payment = Payment.get(id)

    	if (!payment) { response.sendError 404 }

    	[payment:payment]
    }

    def delete(Integer id) {
	    def payment = Payment.get id

	    if (!payment) { response sendError 404 }

	    def sale = payment.sale

	    //remove payment from sale
	    sale.removeFromPayments payment
	  
	    //confirm delete payment
	    if (!payment.delete()) {
	      payment.errors.allErrors.each { println it.defaultMessage }
	    }

	    //update sale balance -> balance + payment (total) <- cash + checks.checksValue.sum() ?: 0
	    sale.balance += payment.getTotalPaid()
	    sale.save()

	    flash.message = "Abono eliminado"
	    redirect controller:"sale", action:"list", params:[status:false, clientId:sale.client.id]
	  }
}
