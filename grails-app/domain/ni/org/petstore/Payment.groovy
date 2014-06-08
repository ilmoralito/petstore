package ni.org.petstore

class Payment implements Serializable {
	BigDecimal payment
	Date dateCreated
	Date lastUpdated

  static constraints = {
  	payment min:0.1, nullable:false
  }

  static belongsTo = [sale:Sale]

  String toString() { payment }
}
