package ni.org.petstore

import grails.util.Holders

class Presentation implements Serializable {
	String presentation

  static constraints = {
  	presentation inList:Holders.config.ni.org.petstore.presentations.keySet() as List, maxSize:255
  }

  static belongsTo = [product:Product]

  List details
  static hasMany = [details:Detail]

  static mapping = { version false }

  String toString() { presentation }

}
