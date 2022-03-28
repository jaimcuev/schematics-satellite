data "ibm_resource_group" "resourceGroup" {
  name = var.resource_group_name
}

data ibm_is_image "image_vm" {
  name = var.image
}

resource "ibm_is_volume" "vpc_cloudpak_volume" {
  count = length(var.zones)
  name = "volumen-${var.project}-cp-${var.environment}-00${count.index + 1}"
  profile = "10iops-tier"
  capacity = 100
  resource_group = data.ibm_resource_group.resourceGroup.id
  zone = var.zones[count.index]
}

resource "ibm_is_instance" "vpc_cloudpak_vsi" {
  count = length(var.zones)
  name = "vm-${var.project}-cp-${var.environment}-00${count.index + 1}"
  image = data.ibm_is_image.image_vm.id
  profile = var.cp_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[count.index].id
    allow_ip_spoofing = false
  }
  volumes = [ ibm_is_volume.vpc_cloudpak_volume[count.index].id ]
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.zones[count.index]
  keys = var.key
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}