package ni.org.petstore

import org.grails.databinding.BindingFormat

class Sale implements Serializable {
  String invoice
	Client client
	Boolean status = false

	@BindingFormat("yyyy-MM-dd")
	Date dateCreated

	static constraints = {
    invoice blank:false, unique:true
		client nullable:false
		payments nullable:true, min:0.0
  }

  static mapping = {
  	version false
  	payments sort: "dateCreated", order: "asc"
  }

  List items
  List payments
  static hasMany = [ items:Item, payments:Payment ]

  BigDecimal getBalance(Payment payment) {
    items.total.sum() - payments.findAll { it.dateCreated <= payment.dateCreated }.payment.sum()
  }

  BigDecimal getDebt() {
    items.total.sum()
  }

  static transients = ["balance", "debt"]

  String toString() { invoice }
}
