package ni.org.petstore

class Detail implements Serializable {
	String measure
	Integer quantity
	BigDecimal price
  BigDecimal total

  static constraints = {
  	measure blank:false
  	quantity min:1, blank:false
  	price min:1.0, blank:false
    total min:0.1, blank:false
  }

  static belongsTo = [presentation:Presentation]

  static mappgin = { version false }

  def beforeInsert() {
    total = price * quantity
  }

  def beforeUpdate() {
    total = price * quantity
  }

  String toString() { measure }
}
