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
        def client1 = new Client(fullName: "Client one", storeName: "Store one", address:"Leon", city: "Leon")

        //emails
        client1.addToEmails "client1@gmail.com"
        client1.addToEmails "client1@hotmail.com"
        client1.addToEmails "client1@yahoo.com"

        //telephones
        def telephone1 = new Telephone(type:"Movistar", number:"88997766")
        def telephone2 = new Telephone(type:"Claro", number:"88557766")

        client1.addToTelephones telephone1
        client1.addToTelephones telephone2

        if (!client1.save()) {
          client1.errors.allErrors.each { println it }
        }

        assert Client.count() == 1
        assert client1.emails.size() == 3
        assert client1.telephones.size() == 2

        //providers
        def provider1 = new Provider(name:"Provider1", contactName:"Juan Perez", contactTelephoneNumber:"23118855")

        if (!provider1.save()) {
          provider1.errors.allErrors.each { println it }
        }

        //products
        def item1 = new Product(name:"item1")

        provider1.addToProducts(item1)

        if (!item1.save()) {
          item1.errors.allErrors.each { println it }
        }

        //Prensenations
        def presentation1 = new Presentation(presentation:"Crema", quantity:15, price:125.5)
        def presentation2 = new Presentation(presentation:"Tableta", quantity:100, price:120)
        def presentation3 = new Presentation(presentation:"Inyectable", quantity:78, price:150)

        item1.addToPresentations presentation1
        item1.addToPresentations presentation2
        item1.addToPresentations presentation3

        if (!presentation1.save()) { presentation1.errors.allErrors.each { println it } }
        if (!presentation2.save()) { presentation2.errors.allErrors.each { println it } }
        if (!presentation3.save()) { presentation3.errors.allErrors.each { println it } }

        assert item1.presentations.size() == 3

        def item2 = new Product(name:"item2")

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
