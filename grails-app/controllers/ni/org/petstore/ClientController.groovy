package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON
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
    sendMail:["GET", "POST"],
    townsByCity:"GET"
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
        params.emails = flow.emails
        def client = new Client(params)

        if (flow.telephones) {
          flow.telephones.each { telephone -> client.addToTelephones telephone }
        }

        if (!client.save()) {
          client.errors.allErrors.each { error -> log.error "[$error.field: $error.defaultMessage]" }

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

  	if (!client) { response.sendError 404 }

  	[client:client]
  }

  def update(Integer id) {
  	def client = Client.get(id)

  	if (!client) { response.sendError 404 }

  	client.properties = params

  	flash.message = client.save() ? "Actualizado" : "A ocurrido un error"
  	redirect action:"edit", params:[id:id]
  }

  def show(Integer id) {
  	def client = Client.get(id)

  	if (!client) { response.sendError 404 }

  	[client:client]
  }

  def addEmail(Integer id, EmailCommand cmd) {
    if (cmd.validate()) {
      def client = Client.get(id)

      if (!client) { response.sendError 404 }

      client.addToEmails cmd.email
      client.save()  
    }  

    redirect action:"show", params:[id:id]
  }

  def deleteEmail(Integer id, String email) {
    def client = Client.get(id)

    if (!client) { response.sendError 404 }

    client.removeFromEmails email
    client.save()

    redirect action:"show", params:[id:id]
  }

  def addTelephone(Integer id, TelephoneCommand cmd) {
    if (cmd.validate()) {
      def client = Client.get(id)

      if (!client) { response.sendError 404 }

      def telephone = new Telephone(type:cmd.type, number:cmd.number)
      client.addToTelephones telephone
      client.save()
    }

    redirect action:"show", params:[id:id]
  }

  def deleteTelephone(Integer id, Integer telephoneId) {
    def client = Client.get(id)

    if (!client) { response.sendError 404 }

    def telephone = Telephone.get(telephoneId)

    if (!telephone) { response.sendError 404 }

    telephone.delete()

    redirect action:"show", params:[id:id]
  }

  def sendMail(Integer id, SendEmailCommand cmd) {
    def client = Client.get(id)

    if (!client) { response.sendError 404 }
    
    if (cmd.validate() && request.method == "POST") {
      sendMail {
        to cmd.emails.toArray()
        subject cmd.subject
        body cmd.body
      }

      flash.message = "Mensaje enviado"
    }

    [client:client]
  }

  def townsByCity(String city) {
    def towns = grailsApplication.config.ni.org.petstore.cities[city]

    render towns as JSON
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

class SendEmailCommand {
  List<String> emails
  String subject
  String body

  static constraints = {
    emails nullable:false
    subject blank:false
    body blank:false
  }
}
