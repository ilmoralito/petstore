dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    production {
      dataSource {
        dbCreate = "update"
        driverClassName = "com.mysql.jdbc.Driver"
        dialect = org.hibernate.dialect.MySQL5InnoDBDialect
        uri = new URI(System.env.CLEARDB_DATABASE_URL?:"//b0f66301cb72fc:9f159dd0@us-cdbr-east-06.cleardb.net/heroku_58fa5c68b592248?reconnect=true")
        url = "jdbc:mysql://"+uri.host+uri.path
        username = uri.userInfo.split(":")[0]
        password = uri.userInfo.split(":")[1]
        properties {
          maxActive = -1
          minEvictableIdleTimeMillis=1800000
          timeBetweenEvictionRunsMillis=1800000
          numTestsPerEvictionRun=3
          testOnBorrow=true
          testWhileIdle=true
          testOnReturn=true
          validationQuery="SELECT 1"
        }
      }
    }
}
