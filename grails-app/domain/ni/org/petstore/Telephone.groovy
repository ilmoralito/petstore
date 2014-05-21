package ni.org.petstore

class Telephone {
	String type
	String number

  static constraints = {
  	type inList:["Movistar", "Claro", "Convencional"], maxSize:255
  	number blank:false, unique:true, maxSize:8, minSize:8
  }

  static belongsTo = [client:Client]

  static mapping = { version false }

  String toString() { "$type $number" }
}
