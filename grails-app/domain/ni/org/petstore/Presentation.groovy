package ni.org.petstore

import grails.util.Holders

class Presentation implements Serializable {
	String presentation
	Integer quantity
	BigDecimal price

  static constraints = {
  	presentation inList:Holders.config.ni.org.petstore.presentations, maxSize:255
  	quantity min:0
  	price min:1.0
  }

  static belongsTo = [product:Product]

  static mapping = { version false }

  String toString() { presentation }

}
