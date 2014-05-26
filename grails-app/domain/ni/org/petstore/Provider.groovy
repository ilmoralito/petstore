package ni.org.petstore

import org.grails.databinding.BindUsing

class Provider {
  @BindUsing({ obj, source ->
    source["name"]?.capitalize()
  })
	String name

  @BindUsing({ obj, source ->
    source["contactName"]?.tokenize(" ")*.capitalize()?.join(" ")
  })
	String contactName
	String contactTelephoneNumber

  static constraints = {
  	name blank:false
  	contactName blank:false
  	contactTelephoneNumber nullable:true, unqiue:true, maxSize:8, minSize:8
  }

  static searchable = true

  static hasMany = [ products : Product ]

  static mapping = { version false }

  String toString() { name }
}
