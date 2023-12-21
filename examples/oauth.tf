terraform {
  required_providers {
    kafka = {
      source = "Mongey/kafka"
      #source  = "terraform-provider-kafka.com/terraform-provider-kafka/kafka"

    }
  }
}

provider "kafka" {
  bootstrap_servers = ["localhost:9094"]

  #ca_cert     = file("../secrets/ca.crt")
  #client_cert = file("../secrets/client.pem")
  #client_key  = file("../secrets/client-no-password.key")
  sasl_mechanism = "oauthbearer"
  sasl_username = "kafka3"
  sasl_password = "/mnt/go-kafka/sample_key"
  tls_enabled = false
  oauth_audience = "http://172.17.0.1:8585/realms/kafka"
  oauth_token_url = "http://172.17.0.1:8585/realms/kafka/protocol/openid-connect/token"
  oauth_scope = "kafka-client"
}


resource "kafka_topic" "syslog" {
  name               = "syslog"
  replication_factor = 1
  partitions         = 4

  config = {
    "segment.ms"   = "4000"
    "retention.ms" = "86400000"
  }

}
