package ni.org.petstore

import org.grails.databinding.BindingFormat

class Sale implements Serializable {
	Client client
	Boolean status = false

	@BindingFormat("yyyy-MM-dd")
	Date dateCreated

	static constraints = {
		client nullable:false
		payments nullable:true
  }

  static mapping = {
  	version false
  	payments sort: "dateCreated", order: "asc"
  }

  List items
  List payments
  static hasMany = [ items:Item, payments:Payment ]

  String toString() { "by $client at $dateCreated" }
}
