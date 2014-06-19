package ni.org.petstore

class Payment implements Serializable {
	BigDecimal payment
	Date dateCreated
	Date lastUpdated

  static constraints = {
  	payment nullable:true, min:0.0
  }

  static belongsTo = [sale:Sale]

  String toString() { payment }
}
