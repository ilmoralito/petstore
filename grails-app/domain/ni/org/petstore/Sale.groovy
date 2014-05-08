package ni.org.petstore

class Sale {
	Client client
	Date dateCreated

	static constraints = {
		client blank:false
  }

  static mapping = { version false }

  static hasMany = [items:Item]

  String toString() { client }
}
