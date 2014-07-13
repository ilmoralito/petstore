package ni.org.petstore

import org.grails.databinding.BindUsing

class Provider implements Serializable {
  @BindUsing({ obj, source ->
    source["name"]?.capitalize()
  })
	String name

  @BindUsing({ obj, source ->
    source["contactName"]?.toLowerCase()?.tokenize(" ")*.capitalize()?.join(" ")
  })
	String contactName

  static constraints = {
  	name blank:false, unique:true
  	contactName blank:false
    providerTelephones nullable:true
  }

  static searchable = true

  List providerTelephones
  static hasMany = [ products:Product, providerTelephones:ProviderTelephone ]

  static mapping = { version false }

  String toString() { name }
}
