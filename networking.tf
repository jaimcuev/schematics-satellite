resource "ibm_is_vpc" "vpc_vm" {
  name = "vpc-${var.project}-${var.environment}-001"
  resource_group = data.ibm_resource_group.resourceGroup.id
  tags = var.tags
}

resource ibm_is_subnet "vpc_subnet" {
  count = 3
  name = "subnet-${var.project}-${var.environment}-00${count.index + 1}"
  vpc  = ibm_is_vpc.vpc_vm.id
  zone = var["zone_${count.index + 1}"]
  ipv4_cidr_block = var["cdir_${count.index + 1}"]
  resource_group = data.ibm_resource_group.resourceGroup.id
}