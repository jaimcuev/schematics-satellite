terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.39.2"
    }
  }
}

provider "ibm" {
  region = var.region
}