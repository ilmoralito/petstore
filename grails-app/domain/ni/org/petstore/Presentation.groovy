package ni.org.petstore

class Presentation {
	String presentation
	Integer quantity

  static constraints = {
  	presentation inList:["Inyeccion", "Pildora", "Jarabe"], maxSize:255
  	quantity min:0
  }

  static belongsTo = [product:Product]

  static mapping = { version false }

  String toString() { presentation }

}
