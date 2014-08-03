import ni.org.petstore.*
import grails.util.Environment
import grails.util.Holders

class BootStrap {
  def init = { servletContext ->
  	def adminRole = Role.findByAuthority("ROLE_ADMIN") ?: new Role(authority: "ROLE_ADMIN").save()
    def userRole = Role.findByAuthority("ROLE_USER") ?: new Role(authority: "ROLE_USER").save()

   	switch(Environment.current) {
   		case Environment.DEVELOPMENT:
   			def testUser = new User(username: "me", password: "password")
   			testUser.save()

				UserRole.create testUser, adminRole, true

				assert User.count() == 1
				assert Role.count() == 2
				assert UserRole.count() == 1

        //clients
        def client1 = new Client(fullName: "Client one", storeName: "Store one", address:"Edgar Lam 1/2 cuadra ariiba", city: "Leon", town: "Achuapa")

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
        def provider1 = new Provider(name:"Provider1", contactName:"Juan Perez")

        //provider telephones
        def providerTelephone1 = new ProviderTelephone(telephoneCarrier:"Movistar", number:"78911041")
        def providerTelephone2 = new ProviderTelephone(telephoneCarrier:"Claro", number:"84386340")

        provider1.addToProviderTelephones providerTelephone1
        provider1.addToProviderTelephones providerTelephone2

        if (!provider1.save()) {
          provider1.errors.allErrors.each { println it }
        }

        //products
        def item1 = new Product(name:"item1", code:"001410")

        provider1.addToProducts(item1)

        if (!item1.save()) {
          item1.errors.allErrors.each { println it }
        }

        def presentations = Holders.config.ni.org.petstore.presentations.keySet()

        //Prensenations
        def presentation1 = new Presentation(presentation:presentations[0])
        def presentation2 = new Presentation(presentation:presentations[1])

        item1.addToPresentations presentation1
        item1.addToPresentations presentation2

        if (!presentation1.save()) { presentation1.errors.allErrors.each { println it } }
        if (!presentation2.save()) { presentation3.errors.allErrors.each { println it } }

        assert item1.presentations.size() == 2

        //presentation details
        def detail1 = new Detail(measure:"5g", quantity:200, price:15.5)
        def detail2 = new Detail(measure:"15g", quantity:80, price:10.6)
        def detail3 = new Detail(measure:"80gm", quantity:80, price:17.6)

        presentation1.addToDetails detail1
        presentation1.addToDetails detail2
        presentation2.addToDetails detail3

        assert presentation1.details.size() == 2
        assert presentation2.details.size() == 1

        def item2 = new Product(name:"item2", code:"001510")

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

        //sale
        def sale1 = new Sale(invoice:"00545", client:client1, status:true)
        def saleItem1 = new Item(
          product:item1,
          presentation:presentation1,
          measure:detail1.measure,
          quantity:5,
          total:detail1.price * 5
        )

        sale1.addToItems saleItem1

        if (!sale1.save()) { sale1.errors.allErrors.each { println it } }

        def sale2 = new Sale(invoice:"00546", client:client1, status:false)
        def saleItem2 = new Item(
          product:item1,
          presentation:presentation1,
          measure:detail1.measure,
          quantity:10,
          total:detail1.price * 10
        )

        sale2.addToItems saleItem2

        if (!sale2.save()) { sale2.errors.allErrors.each { println it } }

        //rest in detail quantity
        detail1.quantity - 15
        detail1.save()

        assert Sale.count() == 2
   		break
      case Environment.PRODUCTION:
        def adminUser = User.findByUsername("adminUser") ?: new User(username:"adminUser", password:"h&p").save()

        if (adminUser.hasErrors()) {
          adminUser.errors.allErrors.each { println it }
        }

        if (!UserRole.findByUserAndRole(adminUser, adminRole)) {
          UserRole.create adminUser, adminRole, true
        }
      break
   	}
  }
  def detail1 = {

  }
}
