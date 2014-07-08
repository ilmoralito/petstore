import grails.util.Holders

class UrlMappings {

	static mappings = {
    "/$controller/$action?/$id?(.$format)?"{
      constraints {
        // apply constraints here
      }
    }

    //client
    "/client/townsByCity/$city"(controller:"client", action:"townsByCity") {
      constraints {
        city inList:Holders.config.ni.org.petstore.cities.keySet() as List
      }
    }

    "/"(controller:"login")
    "/sale"(controller:"sale", action:"buildSale")
    "500"(view:'/error')
	}
}
