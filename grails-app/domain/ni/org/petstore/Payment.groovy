package ni.org.petstore

class Payment implements Serializable {
	BigDecimal payment
	String receipt
  Integer discount
	Date dateCreated
	Date lastUpdated

  static constraints = {
  	receipt blank:false, unique:true
  	payment nullable:true, min:0.0
    discount nullable:true, min:0, max:100
    checks nullable:true
  }

  List checks
  static belongsTo = [sale:Sale]
  static hasMany = [checks:Check]

  String toString() { receipt }
}
