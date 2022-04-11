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

variable "rehl_key" {
  type = list
  default = [""]
  description = "REHL ID Keys"
}

variable "windows_key" {
  type = list
  default = [""]
  description = "Windows ID Keys"
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

variable "worker_profile" {
  default = "gx2-8x64x1v100"
  description = "Profile de la VSI para el Cloud Pak"
}

variable "worker_zones_vsi" {
  type = list
  default = ["us-south-2", "us-south-2", "us-south-3"]
  description = "Zona para cada VSI a crear para el Cloud Pak"
}

variable "worker_storage_capacity" {
  default = "100"
  description = "Capacidad de almacenamiento para cada VSI"
}

variable "odf_profile" {
  default = "bx2-16x64"
  description = "Profile de la VSI para el Openshift Data Foundation"
}

variable "odf_zones_vsi" {
  type = list
  default = ["us-south-1", "us-south-2", "us-south-3"]
  description = "Zona para cada VSI a crear para el Openshift Data Foundation"
}