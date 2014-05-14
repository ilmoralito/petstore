package ni.org.petstore

import org.grails.databinding.BindingFormat

class Sale implements Serializable {
	Client client

	@BindingFormat("yyyy-MM-dd")
	Date dateCreated

	static namedQueries = {
		requestFromTo { from, to ->
	    def f = new Date().parse("yyyy-MM-dd", from)
	    def t = new Date().parse("yyyy-MM-dd", to)

	    ge "dateCreated", f.clearTime()
	    le "dateCreated", t.clearTime()
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
