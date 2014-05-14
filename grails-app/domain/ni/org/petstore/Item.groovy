package ni.org.petstore

class Item implements Serializable {
	Product product
	Presentation presentation
	Integer quantity
	BigDecimal total

  static constraints = {
  	product blank:false
  	presentation blank:false
  	quantity blank:false, min:1
  	total blank:false, min:0.0
  }

  BigDecimal plus(Item other) {
    total + other.total
  }

  static mapping = { version false }

  static belongsTo = [sale:Sale]

  String toString() { product }
}
