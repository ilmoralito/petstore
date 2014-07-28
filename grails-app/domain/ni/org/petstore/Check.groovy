package ni.org.petstore

import grails.util.Holders

class Check implements Serializable {
	String checkNumber
	String banc
	BigDecimal checkValue

  static constraints = {
  	checkNumber blank:false, unique:'banc'
  	banc blank:false, inList:Holders.config.ni.org.petstore.bancs
  	checkValue nullable:false, min:1.0
  }

  static mapping = { version false }

  static belongsTo = [payment:Payment]

  String toString() { checkNumber }
}
