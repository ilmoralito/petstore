package ni.org.petstore

class Payment implements Serializable {
	BigDecimal payment
	String receipt
	Date dateCreated
	Date lastUpdated

  static constraints = {
  	receipt blank:false, unique:true
  	payment nullable:true, min:0.0
  }

  static belongsTo = [sale:Sale]

  String toString() { receipt }
}
