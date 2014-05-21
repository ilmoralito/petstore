package ni.org.petstore

class Client implements Serializable {
	String fullName
	String storeName
	String address
	String city

  static constraints = {
  	fullName blank:false
  	storeName blank:false
  	address blank:false
  	city inList:["Leon", "Matagalpa", "Chinandega", "Corinto", "Esteli", "Granada"], maxSize:255
  }

  static hasMany = [emails:String]

  static mapping = { version false }

  String toString() { fullName }
}
