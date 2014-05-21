package ni.org.petstore

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class ClientController {
	static defaultAction = "list"
	static allowedMethods = [
		list:"GET",
		create:["GET", "POST"],
    delete:"GET",
    edit:"GET",
    update:"POST",
    show:"GET",
    addEmail:"POST",
    deleteEmail:"GET",
    history:"GET",
    sendMail:["GET", "POST"]
	]

  def list() {
  	[clients:Client.list()]
  }

  def create() {
  	def client = new Client(params)

  	if (request.method == "POST") {
  		if (!client.save()) {
  			return [client:client]
  		}

      return
  	}

  	[client:client]
  }

  def delete(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	client.delete()

  	redirect action:"list"
  }

  def edit(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	[client:client]
  }

  def update(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	client.properties = params

  	if (!client.save()) {
  		render view:"edit", model:[client:client]
  		return
  	}

  	redirect action:"edit", params:[id:id]
  }

  def show(Integer id) {
  	def client = Client.get(id)

  	if (!client) {
  		response.sendError 404
  		return
  	}

  	[client:client]
  }

  def addEmail(Integer id, String email) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    client.addToEmails email
    client.save()

    redirect action:"show", params:[id:id]
  }

  def deleteEmail(Integer id, String email) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    client.removeFromEmails email
    client.save()

    redirect action:"show", params:[id:id]
  }

  def addTelephone(Integer id, String type, String number) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    def telephone = new Telephone(type:type, number:number)
    client.addToTelephones telephone
    client.save()

    redirect action:"show", params:[id:id]
  }

  def deleteTelephone(Integer id, Integer telephoneId) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    def telephone = Telephone.get(telephoneId)

    if (!telephone) {
      response.sendError 404
      return
    }

    telephone.delete()

    redirect action:"show", params:[id:id]
  }

  def history(Integer id) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
    }

    if (!params?.dateCreated) {
      def sales = Sale.findAllByClient(client).unique { it.dateCreated.clearTime() }

      [sales:sales]
    } else {
      def dateCreated = params.date("dateCreated", "yyyy-MM-dd")
      def criteria = Item.createCriteria()
      def sales = criteria.list {
        sale {
          eq "dateCreated", dateCreated
          eq "client", client
        }
      }

      [sales:sales.groupBy() { it.product }]
    }
  }

  def sendMail(Integer id) {
    def client = Client.get(id)

    if (!client) {
      response.sendError 404
      return
    }

    [client:client]
  }

}
