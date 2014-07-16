import grails.util.Holders

class UrlMappings {

	static mappings = {
    "/$controller/$action?/$id?(.$format)?"{
      constraints {
        // apply constraints here
      }
    }

    //client
    "/townsByCity/$city"(controller:"client", action:"townsByCity") {
      
    }

    "/"(controller:"login")
    "/sale"(controller:"sale", action:"buildSale")
    "500"(view:'/error')
	}
}
