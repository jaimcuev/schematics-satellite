resource "ibm_is_instance" "vpc_controlplane_vsi" {
  count = length(var.controlplane_zones_vsi)
  name = "vm-${var.project}-${var.environment}-${format("%03s", count.index + 1)}"
  image = data.ibm_is_image.image_vm.id
  profile = var.controlplane_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[index(ibm_is_subnet.vpc_subnet.*.zone, var.controlplane_zones_vsi[count.index])].id
    allow_ip_spoofing = false
  }
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.controlplane_zones_vsi[count.index]
  keys = var.rehl_key
  tags = var.tags
  user_data = <<-EOUD
            #!/bin/bash
            echo '${data.local_file.reregister_vsi.content_base64}' | base64 --decode > /tmp/reregister-ng-rhel-vsi.sh
            echo '${var.satellite_attach_file}' | base64 --decode > /tmp/attachHost-satellite-location.sh
            cd /tmp
            chmod +x reregister-ng-rhel-vsi.sh
            ./reregister-ng-rhel-vsi.sh
            subscription-manager refresh
            subscription-manager repos --enable rhel-server-rhscl-7-rpms
            subscription-manager repos --enable rhel-7-server-optional-rpms
            subscription-manager repos --enable rhel-7-server-rh-common-rpms
            subscription-manager repos --enable rhel-7-server-supplementary-rpms
            subscription-manager repos --enable rhel-7-server-extras-rpms
            sudo nohup bash /tmp/attachHost-satellite-location.sh &
            EOUD
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}