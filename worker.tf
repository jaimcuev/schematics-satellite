resource "ibm_is_instance" "vpc_worker_vsi" {
  count = length(var.worker_zones_vsi)
  
  name = "vm-${var.project}-worker-${var.environment}-${format("%03s", count.index + 1)}"
  image = data.ibm_is_image.image_vm.id
  profile = var.worker_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[index(ibm_is_subnet.vpc_subnet.*.zone, var.worker_zones_vsi[count.index])].id
    allow_ip_spoofing = false
  }
  
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.worker_zones_vsi[count.index]
  volumes = [ibm_is_volume.vpc_worker_volume[count.index].id]
  keys = var.rehl_key
  tags = var.tags
  
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}