package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured
import org.compass.core.engine.SearchEngineQueryParseException

@Secured(["ROLE_ADMIN"])
class ClientController {
	static defaultAction = "list"
	static allowedMethods = [
		list:["GET", "POST"],
    delete:"GET",
    edit:"GET",
    update:"POST",
    show:"GET",
    addEmail:"POST",
    deleteEmail:"GET",
    sendMail:["GET", "POST"]
	]

  def searchableService

  def list() {
    if (!params?.query) {
  	 [clients:Client.list()]
    } else {
      try {
        [clients:searchableService.search(params.query, params).results]
      }
      catch(SearchEngineQueryParseException ex) {
        [parseException: true]
      }
    }
  }

  def createClientFlow = {
    init {
      action {
        flow.emails = []
        flow.telephones = []
      }

      on("success").to "addClient"
    }

    addClient {
      on("addClient") {
        def client = new Client(params)

        if (flow.emails) {
          flow.emails.each { email -> client.addToEmails email }
        }

        if (flow.telephones) {
          flow.telephones.each { telephone -> client.addToTelephones telephone }
        }

        if (!client.save()) {
          client.errors.allErrors.each { println it }

          flow.client = client
          return error()
        }

        session.city = client.city
      }.to "done"

      //EMAIL
      on("addEmail") { EmailCommand cmd ->
        if (cmd.hasErrors()) {
          return error()
        }

        flow.emails.add cmd.email
      }.to "addClient"

      on("deleteEmail") {
        def index = params.int("id")

        flow.emails.remove index
      }.to "addClient"

      //TELEPHONE
      on("addTelephone") { TelephoneCommand cmd ->
        if (cmd.hasErrors()) {
          return error()
        }

        def telephone = new Telephone(type:cmd.type, number:cmd.number)

        flow.telephones.add telephone
      }.to "addClient"

      on("deleteTelephone") {
        def index = params.int("index")

        flow.telephones.remove index
      }.to "addClient"
    }

    done() {
      redirect action:"createClient"
    }
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

  def addEmail(Integer id, String email) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    client.addToEmails email
    client.save()

    redirect action:"show", params:[id:id]
  }

  def deleteEmail(Integer id, String email) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    client.removeFromEmails email
    client.save()

    redirect action:"show", params:[id:id]
  }

  def addTelephone(Integer id, String type, String number) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    def telephone = new Telephone(type:type, number:number)
    client.addToTelephones telephone
    client.save()

    redirect action:"show", params:[id:id]
  }

  def deleteTelephone(Integer id, Integer telephoneId) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    def telephone = Telephone.get(telephoneId)

    if (!telephone) {
      response.sendError 404
      return
    }

    telephone.delete()

    redirect action:"show", params:[id:id]
  }

  def sendMail(Integer id) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    if (request.method == "POST") {
      if (params?.emails) {
        sendMail {
          to params.list("emails").toArray()
          from grailsApplication.config.ni.org.petstore.owner.email
          subject params?.subject
          body params?.body
        }
      }

      flash.message =  (params?.emails) ? "Mensaje enviado" : "No hay emails registrados para este cliente"
    }

    [client:client]
  }

}

class EmailCommand {
  String email

  static constraints = {
    email blank:false, email:true
  }
}

class TelephoneCommand {
  String type
  String number

  static constraints = {
    importFrom Telephone
  }
}
