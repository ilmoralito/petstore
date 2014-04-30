package ni.org.petstore

class Client {
	String fullName
	String storeName
	String address
	String city
	String telephone
	String email

  static constraints = {
  	fullName blank:false
  	storeName blank:false
  	address blank:false
  	city inList:["Leon", "Matagalpa", "Chinandega", "Corinto", "Esteli", "Granada"], maxSize:255
  	telephone nullable:true, maxSize:8
  	email nullable:true, email:true, unique:true
  }

  static mapping = {
  	version false
  }

  String toString() { fullName }
}
