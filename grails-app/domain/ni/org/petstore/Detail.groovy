package ni.org.petstore

class Detail implements Serializable {
	String measure
	Integer quantity
	BigDecimal price

  static constraints = {
  	measure blank:false
  	quantity min:1, blank:false
  	price min:1.0, blank:false
  }

  static belongsTo = [presentation:Presentation]

  static mappgin = { version false }

  String toString() { measure }
}
