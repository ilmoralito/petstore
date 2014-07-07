package ni.org.petstore

import grails.util.Holders
import org.grails.databinding.BindUsing

class Client implements Serializable {
  @BindUsing({ obj, source ->
    source["fullName"]?.tokenize(" ")*.capitalize().join(" ")
  })
	String fullName

	String storeName
	String address
	String city
  String town

  static constraints = {
  	fullName blank:false
  	storeName blank:false
  	address blank:false
  	city inList:Holders.config.ni.org.petstore.cities.keySet() as List, maxSize:255
    town blank:false, maxSize:255, validator:{ val, obj ->
      val in Holders.config.ni.org.petstore.cities[obj.city]
    }
    emails nullable:true
    telephones nullable:true
  }

  static searchable = true

  static hasMany = [emails:String, telephones:Telephone]

  static mapping = {
    version false
    telephones sort:"type", order:"desc"
  }

  String toString() { fullName }
}
