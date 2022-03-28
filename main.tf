data "ibm_resource_group" "resourceGroup" {
  name = var.resource_group_name
}

data ibm_is_image "image_vm" {
  name = var.image
}

data "local_file" "reregister_vsi" {
  filename = "${path.module}/reregister-ng-rhel-vsi.sh"
}

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
  keys = var.key
  tags = var.tags
  user_data = <<-EOUD
            #!/bin/bash
            echo '${data.local_file.reregister_vsi.content_base64}' | base64 --decode > /tmp/reregister-ng-rhel-vsi.sh
            cd /tmp
            chmod +x reregister-ng-rhel-vsi.sh
            ./reregister-ng-rhel-vsi.sh
            subscription-manager refresh
            subscription-manager repos --enable rhel-server-rhscl-7-rpms
            subscription-manager repos --enable rhel-7-server-optional-rpms
            subscription-manager repos --enable rhel-7-server-rh-common-rpms
            subscription-manager repos --enable rhel-7-server-supplementary-rpms
            subscription-manager repos --enable rhel-7-server-extras-rpms &
            EOUD
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_is_instance" "vpc_cloudpak_vsi" {
  count = length(var.cloudpak_zones_vsi)
  name = "vm-${var.project}-cp-${var.environment}-${format("%03s", count.index + 1)}"
  image = data.ibm_is_image.image_vm.id
  profile = var.cloudpak_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[index(ibm_is_subnet.vpc_subnet.*.zone, var.cloudpak_zones_vsi[count.index])].id
    allow_ip_spoofing = false
  }
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.cloudpak_zones_vsi[count.index]
  volumes = [ibm_is_volume.vpc_cloudpak_volume[count.index].id]
  keys = var.key
  tags = var.tags
  user_data = <<-EOUD
          #!/bin/bash
          echo '${data.local_file.reregister_vsi.content_base64}' | base64 --decode > /tmp/reregister-ng-rhel-vsi.sh
          cd /tmp
          chmod +x reregister-ng-rhel-vsi.sh
          ./reregister-ng-rhel-vsi.sh
          subscription-manager refresh
          subscription-manager repos --enable rhel-server-rhscl-7-rpms
          subscription-manager repos --enable rhel-7-server-optional-rpms
          subscription-manager repos --enable rhel-7-server-rh-common-rpms
          subscription-manager repos --enable rhel-7-server-supplementary-rpms
          subscription-manager repos --enable rhel-7-server-extras-rpms &
          EOUD
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_is_instance" "vpc_odf_vsi" {
  count = length(var.odf_zones_vsi)
  name = "vm-${var.project}-odf-${var.environment}-${format("%03s", count.index + 1)}"
  image = data.ibm_is_image.image_vm.id
  profile = var.cloudpak_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[index(ibm_is_subnet.vpc_subnet.*.zone, var.odf_zones_vsi[count.index])].id
    allow_ip_spoofing = false
  }
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.odf_zones_vsi[count.index]
  volumes = [
    ibm_is_volume.vpc_odf_1_volume[count.index].id, 
    ibm_is_volume.vpc_odf_2_volume[count.index].id
  ]
  keys = var.key
  tags = var.tags
  user_data = <<-EOUD
        #!/bin/bash
        echo '${data.local_file.reregister_vsi.content_base64}' | base64 --decode > /tmp/reregister-ng-rhel-vsi.sh
        cd /tmp
        chmod +x reregister-ng-rhel-vsi.sh
        ./reregister-ng-rhel-vsi.sh
        subscription-manager refresh
        subscription-manager repos --enable rhel-server-rhscl-7-rpms
        subscription-manager repos --enable rhel-7-server-optional-rpms
        subscription-manager repos --enable rhel-7-server-rh-common-rpms
        subscription-manager repos --enable rhel-7-server-supplementary-rpms
        subscription-manager repos --enable rhel-7-server-extras-rpms &
        EOUD
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}