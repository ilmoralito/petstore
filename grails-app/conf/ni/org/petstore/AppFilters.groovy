package ni.org.petstore

class AppFilters {
  def filters = {
    all(controller:"*", action:"*") {
      before = {
        
      }
    }
  }
}
