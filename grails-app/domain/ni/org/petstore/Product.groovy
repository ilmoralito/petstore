package ni.org.petstore

import org.grails.databinding.BindUsing

class Product implements Serializable {
	@BindUsing({ obj, source ->
		source["name"]?.toLowerCase()?.tokenize(" ")*.capitalize().join(" ")
	})
	String name
  String code

  static constraints = {
  	name blank:false
    code blank:false, unique:true
  }

  List presentations

  static belongsTo = [ provider:Provider ]
  static hasMany = [ presentations:Presentation ]

  static mapping = { version false }

  String toString() { name }
}
