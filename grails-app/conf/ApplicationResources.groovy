modules = {
  app {
  	resource url:"css/app.css"
  }

  appJs {
  	dependsOn "app, jquery"
  	resource url:"js/application.js"
  }
}