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

variable "zones" {
  type = list
  default = ["us-south-1", "us-south-2", "us-south-3"]
  description = "Zonas donde se crearan los recursos"
}

variable "cdirs" {
  type = list
  default = ["10.240.0.0/18", "10.240.64.0/18", "10.240.128.0/18"]
  description = "Rango de IPs por zona"
}

variable "image" {
  default = "ibm-redhat-7-9-minimal-amd64-5"
  description = "Imagen que se usara para la VSI"
}

variable "key" {
  type = list
  default = [""]
  description = "ID Keys"
}

variable "controlplane_profile" {
  default = "bx2-4x16"
  description = "Profile de la VSI para el Control Plane"
}

variable "controlplane_zones_vsi" {
  type = list
  default = ["us-south-1", "us-south-2", "us-south-3"]
  description = "Zona para cada VSI a crear para el Control Plane"
}

variable "cloudpak_profile" {
  default = "gx2-8x64x1v100"
  description = "Profile de la VSI para el Cloud Pak"
}

variable "cloudpak_zones_vsi" {
  type = list
  default = ["us-south-2", "us-south-2", "us-south-3"]
  description = "Zona para cada VSI a crear para el Cloud Pak"
}