resource "ibm_is_vpc" "vpc_vm" {
    name = "vpc-${var.project}-${var.environment}-001"
    resource_group = data.ibm_resource_group.resourceGroup.id
    tags = var.tags
}

resource ibm_is_subnet "vpc_subnet" {
    name = "subnet-${var.project}-${var.environment}-001"
    vpc  = ibm_is_vpc.vpc_vm.id
    zone = var.zone_1
    ipv4_cidr_block = var.cdir_1
    resource_group = data.ibm_resource_group.resourceGroup.id
}

resource ibm_is_subnet "vpc_subnet" {
    name = "subnet-${var.project}-${var.environment}-002"
    vpc  = ibm_is_vpc.vpc_vm.id
    zone = var.zone_2
    ipv4_cidr_block = var.cdir_2
    resource_group = data.ibm_resource_group.resourceGroup.id
}

resource ibm_is_subnet "vpc_subnet" {
    name = "subnet-${var.project}-${var.environment}-003"
    vpc  = ibm_is_vpc.vpc_vm.id
    zone = var.zone_3
    ipv4_cidr_block = var.cdir_3
    resource_group = data.ibm_resource_group.resourceGroup.id
}