package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class MessageController {

	static defaultAction = "message"
	static allowedMethods = [
		message:"GET",
		confirm:"POST",
		cancel:"POST"
	]

  def message() {
  	[params:params]
  }

  def confirm(String ctrl, Integer id) {
  	redirect controller:ctrl, action:"delete", id:id
  }

  def cancel(String ctrl, String act) {
  	redirect controller:ctrl, action:act
  }
}
