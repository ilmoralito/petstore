import ni.org.petstore.*
import grails.util.GrailsUtil

class BootStrap {
  def init = { servletContext ->
  	def adminRole = new Role(authority: "ROLE_ADMIN").save()
    def userRole = new Role(authority: "ROLE_USER").save()

   	switch(GrailsUtil.environment) {
   		case "development":
   			def testUser = new User(username: "me", password: "password")
   			testUser.save()

				UserRole.create testUser, adminRole, true

				assert User.count() == 1
				assert Role.count() == 2
				assert UserRole.count() == 1

        //clients
        def client1 = new Client(fullName: "Client one", storeName: "Store one", address:"Leon", city: "Leon", telephone:"23114455", email:"clientone@email.com")

        if (!client1.save()) {
          client1.errors.allErrors.each {
            println it
          }
        }

        assert Client.count() == 1
   		break
   	}
  }
  def destroy = {

  }
}
