package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class PaymentController {

		static defaultAction = "show"
		static allowedMethods = [show:"GET"]

    def show(Long id) {
    	def payment = Payment.get(id)

    	if (!payment) { response.sendError 404 }

    	[payment:payment]
    }
}
