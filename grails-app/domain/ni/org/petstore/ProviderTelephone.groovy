package ni.org.petstore

import java.util.regex.Matcher
import java.util.regex.Pattern

class ProviderTelephone implements Serializable {
	String telephoneCarrier
	String number

  static constraints = {
  	telephoneCarrier blank:false, inList:["Convencional", "Claro", "Movistar"]
  	number blank:false, unique:true, maxSize:8, minSize:8
  }

  static mapping = { version false }

  static belongsTo = [provider:Provider]

  String toString() { "$telephoneCarrier $number" }
}
