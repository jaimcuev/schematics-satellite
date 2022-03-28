data "ibm_resource_group" "resourceGroup" {
  name = var.resource_group_name
}

data ibm_is_image "image_vm" {
  name = var.image
}

data "local_file" "reregister_vsi" {
  filename = "${path.module}/reregister-ng-rhel-vsi.sh"
}