package ni.org.petstore

import org.grails.databinding.BindingFormat

class Sale implements Serializable {
  String invoice
	Client client
  BigDecimal balance
	Boolean status = false

	@BindingFormat("yyyy-MM-dd")
	Date dateCreated

	static constraints = {
    invoice blank:false, unique:true
		client nullable:false
    balance nullable:true, min:0.0
    items nullable:false
		payments nullable:true
  }

  static mapping = {
  	version false
  	payments sort: "dateCreated", order: "asc"
  }

  def beforeInsert() {
    balance = items.total.sum()
  }

  List items
  List payments
  static hasMany = [ items:Item, payments:Payment ]

  String toString() { invoice }
}
