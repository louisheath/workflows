terraform {
  required_providers {
    incident = {
      source  = "incident-io/incident"
      version = "3.0.0"
    }
  }
}

provider "incident" {}
