package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class ClientController {
	static defaultAction = "list"
	static allowedMethods = [
		list:"GET",
		create:["GET", "POST"],
    delete:"GET",
    edit:"GET",
    update:"POST",
    show:"GET",
    history:["GET", "POST"],
    sendMail:["GET", "POST"]
	]

  def list() {
  	[clients:Client.list()]
  }

  def create() {
  	def client = new Client(params)

  	if (request.method == "POST") {
  		if (!client.save()) {
  			return [client:client]
  		}

      return
  	}

  	[client:client]
  }

  def delete(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	client.delete()

  	redirect action:"list"
  }

  def edit(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	[client:client]
  }

  def update(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	client.properties = params

  	if (!client.save()) {
  		render view:"edit", model:[client:client]
  		return
  	}

  	redirect action:"edit", params:[id:id]
  }

  def show(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	[client:client]
  }

  def history(Integer id) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    [client:client]
  }

  def sendMail(Integer id) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    [client:client]
  }

}
