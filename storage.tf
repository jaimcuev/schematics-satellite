resource "ibm_is_volume" "vpc_cloudpak_volume" {
  count = length(var.zones)
  name = "volumen-${var.project}-cp-${var.environment}-${format("%02s", count.index)}"
  profile = "10iops-tier"
  capacity = 100
  resource_group = data.ibm_resource_group.resourceGroup.id
  zone = var.zones[count.index]
  tags = var.tags
}