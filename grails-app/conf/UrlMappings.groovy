class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"login")
        "/sale"(controller:"sale", action:"buildSale")
        "500"(view:'/error')
	}
}
