variable "ibmcloud_api_key" {
  default = ""
  description = "IBM Cloud API key requerido para crear componentes"
}

variable "resource_group_name" {
  default = ""
  description = "Nombre del resource group donde se desea crear los recursos"
}

variable "region" {
  default = "us-south"
  description = "Region donde se crearan los componentes"
}

variable "tags" {
  type = list
  default = ["project", "owner"]
  description = "Tags para identificar componentes"
}

variable "project" {
  default = "demo"
  description = "Nombre del proyecto para el cual se crea el cluster"
}

variable "environment" {
  default = "dev"
  description = "Ambiente para el cual se crea el cluster"
}

variable "zone_1" {
  default = "us-south-1"
  description = "Zona 1 donde se crearan los recursos"
}

variable "zone_2" {
  default = "us-south-2"
  description = "Zona 2 donde se crearan los recursos"
}

variable "zone_3" {
  default = "us-south-3"
  description = "Zona 3 donde se crearan los recursos"
}

variable "cdir_1" {
  default = "10.240.0.0/18"
  description = "Rango de IPs para la zona 1"
}

variable "cdir_2" {
  default = "10.240.64.0/18"
  description = "Rango de IPs para la zona 2"
}

variable "cdir_3" {
  default = "10.240.128.0/18"
  description = "Rango de IPs para la zona 3"
}