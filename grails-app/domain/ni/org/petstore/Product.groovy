package ni.org.petstore

class Product {
	String name
	BigDecimal price
	Boolean inyeccion
	Boolean tableta
	Boolean jarabe
	Boolean unbuento
	Boolean gel

  static constraints = {
  	name blank:false
  	price min:1.0
  }

  static belongsTo = [ provider : Provider ]

  static mapping = { version false }

  String toString() { name }
}
