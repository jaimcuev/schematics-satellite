data "ibm_resource_group" "resourceGroup" {
  name = var.resource_group_name
}

data ibm_is_image "image_vm" {
  name = var.image
}

resource "ibm_is_volume" "vpc_cloudpak_volume" {
  count = length(var.zones)
  name = "volumen-${var.project}-${var.environment}-00${count.index + 1}"
  profile = "10iops-tier"
  resource_group = data.ibm_resource_group.resourceGroup.id
  zone = var.zones[count.index]
}