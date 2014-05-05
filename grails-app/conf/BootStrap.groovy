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

        //providers
        def provider1 = new Provider(name:"Provider1", contactName:"Juan Perez", contactTelephoneNumber:"23118855")

        if (!provider1.save()) {
          provider1.errors.allErrors.each { println it }
        }

        //products
        def item1 = new Product(name:"item1",price:200)

        provider1.addToProducts(item1)

        if (!item1.save()) {
          item1.errors.allErrors.each { println it }
        }

        //Prensenations
        def presentation1 = new Presentation(presentation:"Inyeccion", quantity:15)
        def presentation2 = new Presentation(presentation:"Pildora", quantity:100)
        def presentation3 = new Presentation(presentation:"Jarabe", quantity:100)

        item1.addToPresentations presentation1
        item1.addToPresentations presentation2
        item1.addToPresentations presentation3

        if (!presentation1.save()) { presentation1.errors.allErrors.each { println it } }
        if (!presentation2.save()) { presentation2.errors.allErrors.each { println it } }
        if (!presentation3.save()) { presentation3.errors.allErrors.each { println it } }

        assert item1.presentations.size() == 3

        def item2 = new Product(
          name:"item2",
          price:300
        )

        provider1.addToProducts(item2)

        if (!item2.save()) {
          item1.errors.allErrors.each { println it }
        }

        assert provider1.products.size() == 2

        def provider2 = new Provider(name:"Provider2", contactName:"Juan Perez Lopez", contactTelephoneNumber:"23188855")

        if (!provider2.save()) {
          provider2.errors.allErrors.each { println it }
        }

        assert Provider.count() == 2

   		break
   	}
  }
  def destroy = {

  }
}
