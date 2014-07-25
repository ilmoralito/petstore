modules = {
  app {
  	resource url:"css/app.css"
  }

  appJs {
  	dependsOn "app, jquery"
  	resource url:"js/application.js"
  }

  appStorage {
  	dependsOn "app, jquery"
  	resource url:"js/storage.js"
    resource url:"js/town.js"
  }

  appTown {
    dependsOn "app, jquery"
    resource url:"js/town.js"
  }

  appProviderStorage {
    dependsOn "app, jquery"
    resource url:"js/providerStorage.js"
  }

  printInvoice {
    resource url:"css/bootstrap.min.css", attrs:[media:"print"]
    resource url:"css/printInvoice.css", attrs:[media:"print"]
  }
}