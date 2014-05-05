package ni.org.petstore

class Product {
	String name
	BigDecimal price

  static constraints = {
  	name blank:false
  	price min:1.0
  }

  List presentations

  static belongsTo = [ provider:Provider ]
  static hasMany = [ presentations:Presentation ]

  static mapping = { version false }

  String toString() { name }
}
