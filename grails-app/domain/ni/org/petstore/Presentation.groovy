package ni.org.petstore

class Presentation {
	String presentation
	Integer quantity
	BigDecimal price

  static constraints = {
  	presentation inList:["Crema", "Spray", "Tableta", "Soluble", "Suspencion", "Inyectable"], maxSize:255
  	quantity min:0
  	price min:1.0
  }

  static belongsTo = [product:Product]

  static mapping = { version false }

  String toString() { presentation }

}
