package ni.org.petstore

import grails.util.Holders

class Client implements Serializable {
	String fullName
	String storeName
	String address
	String city

  static constraints = {
  	fullName blank:false
  	storeName blank:false
  	address blank:false
  	city inList:Holders.config.ni.org.petstore.cities, maxSize:255
  }

  static searchable = true

  static hasMany = [emails:String, telephones:Telephone]

  static mapping = {
    version false
    telephones sort:"type", order:"desc"
  }

  String toString() { fullName }
}
