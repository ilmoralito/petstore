package ni.org.petstore

class Item {
	Product product
	Integer quantity

  static constraints = {
  	product blank:false
  	quantity blank:false, min:1
  }

  static mapping = { version false }

  static belongsTo = [sale:Sale]

  String toString() { product }
}
