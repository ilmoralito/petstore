package ni.org.petstore

import org.grails.databinding.BindUsing

class Product implements Serializable {
	@BindUsing({ obj, source ->
		source["name"]?.toLowerCase()?.tokenize(" ")*.capitalize().join(" ")
	})
	String name

  static constraints = {
  	name blank:false
  }

  List presentations

  static belongsTo = [ provider:Provider ]
  static hasMany = [ presentations:Presentation ]

  static mapping = { version false }

  String toString() { name }
}
