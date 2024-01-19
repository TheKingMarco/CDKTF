LOCATION          = "westeurope"
ENVIRONMENT       = "noprod"
WORKLOAD          = "tf"
SUBSCRIPTION_TYPE = "eni"
AZURE_REGION      = "we"

ACI = {
  "group-test" = {
    ip_address_type = "Public"
    os_type         = "Linux"
    container = [
      {
        name   = "sonarqube-sql"
        image  = "sonarqube"
        cpu    = "1"
        memory = "2"
        ports = [
          {
            port     = 9000
            protocol = "TCP"
          },
          {
            port     = 9092
            protocol = "TCP"
          },
          {
            port     = 1433
            protocol = "TCP"
        }]
        environment_variables = {
          SONAR_JDBC_USERNAME = "marco"
          SONAR_JDBC_PASSWORD = "Complicatissima1!"
          SONAR_JDBC_URL                  = "jdbc:sqlserver://sonarqube-marco.database.windows.net:1433;database=sonar"
          SONAR_SEARCH_JAVAADDITIONALOPTS = "-Dnode.store.allow_mmap=false"
        }
      },
      {
        name   = "mattermost"
        image  = "mattermost/mattermost-preview"
        cpu    = "1"
        memory = "2"
        ports = [
          {
            port     = 80
            protocol = "TCP"
          },
          {
            port     = 8065
            protocol = "TCP"
          }
        ]
        environment_variables = {}
      }
    ]
  }
  #   "group-sonar" = {
  #     ip_address_type = "Public"
  #     os_type         = "Linux"
  #     container = [{
  #       name   = "mettermost"
  #       image  = "mettermost/mettermost-preview"
  #       cpu    = "2"
  #       memory = "3.5"
  #       ports = [
  #         {
  #           port     = 9000
  #           protocol = "TCP"
  #         },
  #         {
  #           port     = 9001
  #           protocol = "TCP"
  #         },
  #         {
  #           port     = 9002
  #           protocol = "TCP"
  #       }]
  #     }]
  #   },
  #   "group-mattermost" = {
  #     ip_address_type = "Public"
  #     os_type         = "Linux"
  #     container = [{
  #       name   = "mattermost"
  #       image  = "mattermost/mattermost-preview"
  #       cpu    = "2"
  #       memory = "3.5"
  #       ports = [
  #         {
  #           port     = 9000
  #           protocol = "TCP"
  #         },
  #         {
  #           port     = 9001
  #           protocol = "TCP"
  #         },
  #         {
  #           port     = 9002
  #           protocol = "TCP"
  #       }]
  #     }]
  #   }
}