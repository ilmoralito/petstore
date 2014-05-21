package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured
import org.compass.core.engine.SearchEngineQueryParseException

@Secured(["ROLE_ADMIN"])
class ProviderController {
	static defaultAction = "list"
	static allowedMethods = [
		list:["GET", "POST"],
		create:["GET", "POST"],
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

  def create() {
  	def provider = new Provider(params)

  	if (request.method == "POST") {
  		if (!provider.save()) {
  			return [provider:provider]
  		}

  		return
  	}

  	[provider:provider]
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
