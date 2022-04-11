resource "ibm_is_volume" "vpc_worker_volume" {
  count = length(var.worker_zones_vsi)
  name = "volumen-${var.project}-worker-${var.environment}-${format("%03s", count.index + 1)}"
  profile = "10iops-tier"
  capacity = var.worker_storage_capacity
  
  resource_group = data.ibm_resource_group.resourceGroup.id
  zone = var.worker_zones_vsi[count.index]
  tags = var.tags
}

resource "ibm_is_volume" "vpc_odf_1_volume" {
  count = length(var.odf_zones_vsi)
  name = "volumen-${var.project}-odf-${var.environment}-${format("%03s", count.index + 1)}"
  profile = "10iops-tier"
  capacity = 100
  
  resource_group = data.ibm_resource_group.resourceGroup.id
  zone = var.odf_zones_vsi[count.index]
  tags = var.tags
}

resource "ibm_is_volume" "vpc_odf_2_volume" {
  count = length(var.odf_zones_vsi)
  name = "volumen-${var.project}-odf-${var.environment}-${format("%03s", count.index + 1 + length(var.odf_zones_vsi))}"
  profile = "10iops-tier"
  capacity = 500
  
  resource_group = data.ibm_resource_group.resourceGroup.id
  zone = var.odf_zones_vsi[count.index]
  tags = var.tags
}