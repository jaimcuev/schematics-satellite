resource "ibm_is_vpc" "vpc_vm" {
  name = "vpc-${var.project}-${var.environment}-001"
  resource_group = data.ibm_resource_group.resourceGroup.id
  tags = var.tags
}

resource "ibm_is_public_gateway" "vpc_gateway" {
  count = length(var.zones)
  name = "gateway-${var.project}-${var.environment}-${format("%02s", count.index)}"
  vpc  = ibm_is_vpc.vpc_vm.id
  zone = var.zones[count.index]
  resource_group = data.ibm_resource_group.resourceGroup.id
  tags = var.tags
}

resource ibm_is_subnet "vpc_subnet" {
  count = length(var.zones)
  name = "subnet-${var.project}-${var.environment}-${format("%02s", count.index)}"
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.zones[count.index]
  ipv4_cidr_block = var.cdirs[count.index]
  resource_group = data.ibm_resource_group.resourceGroup.id
  public_gateway = ibm_is_public_gateway.vpc_gateway[count.index].id
  tags = var.tags
}

data "ibm_is_security_group" "vpc_security_group" {
  name = ibm_is_vpc.vpc_vm.security_group[0].group_name
}