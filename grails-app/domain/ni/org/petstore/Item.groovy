package ni.org.petstore

class Item implements Serializable {
	Product product
	Presentation presentation
  String measure
	Integer quantity
	BigDecimal total

  static constraints = {
  	product nullable:false
  	presentation nullable:false
    measure blank:false
  	quantity nullable:false, min:1
  	total nullable:false, min:0.0
  }
  
  static mapping = { version false }

  static belongsTo = [sale:Sale]

  String toString() { product }
}
