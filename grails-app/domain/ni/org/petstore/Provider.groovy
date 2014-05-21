package ni.org.petstore

class Provider {
	String name
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
