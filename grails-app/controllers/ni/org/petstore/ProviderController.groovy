package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured
import org.compass.core.engine.SearchEngineQueryParseException

@Secured(["ROLE_ADMIN"])
class ProviderController {
	static defaultAction = "list"
	static allowedMethods = [
		list:["GET", "POST"],
		edit:"GET",
		update:"POST",
		delete:"GET"
	]

  def searchableService

  def list() {
    if (!params?.query) {
  	 [providers:Provider.list()]
    } else {
      try {
        [providers:searchableService.search(params.query, params).results]
      }
      catch(SearchEngineQueryParseException ex) {
        [parseException: true]
      }
    }
  }

  def createProviderFlow = {
  	init {
      action {
        flow.telephones = []
      }

      on("success").to "addProvider"
    }

    addProvider {
      on("confirm") { ProviderCommand cmd ->
        if (cmd.hasErrors()) {
          cmd.errors.allErrors.each { println it }
          return error()
        }

        Provider provider = new Provider(name:cmd.name, contactName:cmd.contactName)
        
        if (flow.telephones) {
          flow.telephones.each { telephone ->  provider.addToProviderTelephones telephone }
        }

        provider.save()
      }.to "done"

      on("addTelephone") { TelephoneCommand cmd ->
        if (cmd.hasErrors() || flow.telephones.find { it.number == cmd.number }) {
          cmd.errors.allErrors.each { println it }
          return error()
        }
        
        ProviderTelephone telephone = new ProviderTelephone(
          telephoneCarrier:cmd.telephoneCarrier,
          number:cmd.number
        )

        flow.telephones.add telephone
      }.to "addProvider"

      on("deleteTelephone") {
        def index = params.int("index")

        flow.telephones.remove index
      }.to "addProvider"
    }

    done() {
      redirect action:"createProvider"
    }
  }

  def edit(Integer id) {
  	def provider = Provider.get(id)

  	if (!provider) {
  		response.sendError 404
  	}

  	[provider:provider]
  }

  def update(Integer id) {
  	def provider = Provider.get(id)

  	if (!provider) {
  		response.sendError 404
  	}

  	provider.properties = params

  	if (!provider.save()) {
  		render view:"edit", model:[provider:provider]
  		return
  	}

  	redirect action:"edit", params:[id:id]
  }

  def delete(Integer id) {
  	def provider = Provider.get(id)

  	if (!provider) {
  		response.sendError 404
  	}

  	provider.delete()

  	redirect action:"list"
  }
}

class TelephoneCommand {
  String telephoneCarrier
  String number

  static constraints = {
    importFrom ProviderTelephone
  }
}

class ProviderCommand {
  String name
  String contactName

  static constraints = {
    importFrom Provider
  }
}