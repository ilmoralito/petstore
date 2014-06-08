package ni.org.petstore

import org.grails.databinding.BindingFormat

class Sale implements Serializable {
	Client client
	Boolean status = false

	@BindingFormat("yyyy-MM-dd")
	Date dateCreated

	static namedQueries = {
		requestFromTo { from, to ->
	    ge "dateCreated", from
	    le "dateCreated", to + 1
    }
	}

	static constraints = {
		client blank:false
  }

  static mapping = { version false }

  List items
  static hasMany = [items:Item]

  String toString() { client }
}
