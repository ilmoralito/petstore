// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

//grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = "ni.org.petstore" // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']
grails.resources.adhoc.includes = ['/images/**', '/css/**', '/js/**', '/plugins/**']

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://provetnicsa.herokuapp.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

//app config data
ni.org.petstore.owner = [email:"provetnicsa@yahoo.es", name:"Hector Salinas"]
ni.org.petstore.presentations = [
  "Crema":
    ["5g", "15g", "30g","50g"],
  "Talco":
    ["80gm"],
  "Spray":
    ["120ml", "150ml", "250ml", "356ml", "475ml", "159gm"],
  "Tableta":
    ["2tabs", "4tabs", "6tabs", "8tabs", "10tabs", "24tabs", "50tabs", "60tabs", "100tabs", "300tabs"],
  "Soluble":
    ["20g", "25g", "100g", "125g", "200g", "1kg"],
  "Suspencion":
    ["120ml", "360ml"],
  "Inyectable":
    ["10ml", "20ml", "50ml", "100ml", "250ml", "500ml"]
]
ni.org.petstore.cities = [
  "Leon":["Achuapa", "El Jicaral", "El Sauce", "La Paz Centro", "Larreynaga", "Leon", "Nagarote", "Quezalguaque", "Santa Rosa del Penon", "Telica"],
  "Matagalpa":["Ciudad Dario", "La Dalia", "Esquipulas", "Matagalpa", "Matiguas", "Muy Muy", "Rancho Grande", "Rio Blanco", "San Dionisio", "San Isidro", "San Ramon", "Sebaco", "Terrabona"],
  "Chinandega":["Chichigalpa", "Chinandega", "Cinco Pinos", "Corinto", "El Realejo", "El Viejo", "Posoltega", "San Francisco del Norte", "San Pedro del Norte", "Santo Tomas del Norte", "Somotillo", "Puerto Morazan", "Villanueva"],
  "Jinotega":["El Cua", "Jinotega", "La Concordia", "Bocay", "San Rafael del Norte", "Yali", "Santa Maria de Pantasma", "Wiwili"],
  "Esteli":["Condega", "Esteli", "La Trinidad", "Pueblo Nuevo", "San Juan de Limay", "San Nicolas"],
  "Atlantico Norte":["Bilwi", "Bonanza", "Mulukuku", "Prinzapolka", "Rosita", "Siuna", "Waslala", "Waspam"]
]
ni.org.petstore.bancs = ["BAC", "BANCENTRO", "CITI", "BANPRO", "PROCREDIT"]

grails {
  mail {
    host = "smtp.gmail.com"
    port = 465
    username = System.env.GMAIL_EMAIL
    password = System.env.GMAIL_PASSWORD
    props = ["mail.smtp.auth":"true", "mail.smtp.socketFactory.port":"465", "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory", "mail.smtp.socketFactory.fallback":"false"]
  } 
}

grails.mail.default.from = "provetnicsa@yahoo.es"

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'ni.org.petstore.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'ni.org.petstore.UserRole'
grails.plugin.springsecurity.authority.className = 'ni.org.petstore.Role'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.successHandler.defaultTargetUrl = "/sale"
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':                              ['permitAll'],
	'/index':                         ['permitAll'],
	'/index.gsp':                     ['permitAll'],
	'/**/js/**':                      ['permitAll'],
	'/**/css/**':                     ['permitAll'],
	'/**/images/**':                  ['permitAll'],
	'/**/favicon.ico':                ['permitAll']
]

