package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

class UserController {
		def springSecurityService

		static defaultAction = "profile"
		static allowedMethods = [
			profile:["GET", "POST"],
			password:["GET", "POST"]
		]

		@Secured(["ROLE_ADMIN"])
    def profile() {
   		def id = springSecurityService.principal.id
 			def user = User.get(id)

   		if (request.method == "POST") {
    		user.properties["username"] = params?.username

    		if (!user.save()) {
    			return [user:user]
    		}

    	}

    	[user:user]
    }

		@Secured(["ROLE_ADMIN"])
    def password(changePasswordCommand cmd) {
    	if (request.method == "POST") {
    		if (cmd.hasErrors()) {
	    		return [cmd:cmd]
	    	}

	    	def currentUser = springSecurityService.currentUser
	    	currentUser.properties["password"] = cmd.newPassword

	    	if (!currentUser.save()) {
	    		return [cmd:cmd]
	    	}

	    	flash.message = "Clave actualizada"
    	}
    }
}

class changePasswordCommand {
		def springSecurityService
		def passwordEncoder

		String currentPassword
		String newPassword
		String repeatNewPassword

		static constraints = {
			currentPassword blank:false, validator: { val, obj ->
				def currentUser = obj.springSecurityService.currentUser
				def currentUserPassword = currentUser.password

				obj.passwordEncoder.isPasswordValid(currentUserPassword, val, null)
			}
			newPassword blank:false
			repeatNewPassword blank:false, validator: { val, obj ->
				val == obj.newPassword
			}
	}
}
