data "ibm_resource_group" "resourceGroup" {
  name = var.resource_group_name
}

data ibm_is_image "image_vm" {
  name = var.image
}

resource "ibm_is_instance" "vpc_controlplane_vsi" {
  count = 3
  name = "vm-${var.project}-cp-${var.environment}-00${count.index + 1}"
  image = data.ibm_is_image.image_vm.id
  profile = var.controlplane_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[count.index].id
    allow_ip_spoofing = false
  }
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.zones[count.index]
  keys = var.key
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}