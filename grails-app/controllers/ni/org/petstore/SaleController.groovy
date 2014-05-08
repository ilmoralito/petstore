package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class SaleController {
	static defaultAction = "create"
	static allowedMethods = [
		list:"GET",
		create:["GET", "POST"]
	]

	def list() {

	}

	def create() {
		def productCriteria = Product.createCriteria()
		def products = productCriteria.list {
			sizeGt "presentations", 0
		}

		//def products = Product.findAll { presentations.size() > 0 }

		[clients:Client.list(), products:products]
	}

	def addProductFlow() {
		
	}
}
