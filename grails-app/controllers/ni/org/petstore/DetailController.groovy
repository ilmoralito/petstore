package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class DetailController {
	static defaultAction = "edit"
	static allowedMethods = "GET"
	
	def edit(Integer id) {
		def detail = Detail.get(id)

		if (!detail) { response.sendError 404 }

		[detail:detail]
	}

	def update(Integer id) {
		def detail = Detail.get(id)

		if (!detail) { response.sendError 404 }

		detail.properties["quantity", "price"] = params

		if (!detail.save()) {
			detail.errors.allErrors.each { println it }
		} else {
			flash.message = "Detalle confirmado"
		}

		println detail.validate()
		redirect action:"edit", id:id
	}
}
