package ni.org.petstore

class Product {
	String name

  static constraints = {
  	name blank:false
  }

  List presentations

  static belongsTo = [ provider:Provider ]
  static hasMany = [ presentations:Presentation ]

  static mapping = { version false }

  String toString() { name }
}
