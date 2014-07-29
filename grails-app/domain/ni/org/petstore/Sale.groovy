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

  BigDecimal getMainBalance() {
    items.total.sum()
  }

  BigDecimal getBalance(Payment payment) {
    def cash = payments?.payment?.sum() ?: 0
    def checkValues = payment?.checks?.checkValue?.sum()

    println cash
    println checkValues

    this.getMainBalance() - (cash + checkValues)
  }

  static transients = ["mainBalance", "balance"]

  String toString() { invoice }
}
