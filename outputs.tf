output vpc_id {
  value = ibm_is_vpc.vpc_vm.id
}

output storage {
  value = ibm_is_volume.vpc_cloudpak_volume.id
}