data "ibm_resource_group" "resourceGroup" {
  name = var.resource_group_name
}

data ibm_is_image "image_vm" {
  name = var.image
}

data "local_file" "reregister_vsi" {
  filename = "${path.module}/reregister-ng-rhel-vsi.sh"
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

resource "ibm_is_instance" "vpc_odf_vsi" {
  count = length(var.odf_zones_vsi)
  name = "vm-${var.project}-odf-${var.environment}-${format("%03s", count.index + 1)}"
  image = data.ibm_is_image.image_vm.id
  profile = var.odf_profile
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[index(ibm_is_subnet.vpc_subnet.*.zone, var.odf_zones_vsi[count.index])].id
    allow_ip_spoofing = false
  }
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.odf_zones_vsi[count.index]
  volumes = [ibm_is_volume.vpc_odf_1_volume[count.index].id]
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

resource "ibm_is_instance" "vpc_windows_vsi" {
  name = "vm-${var.project}-windows-${var.environment}-001"
  image = "r006-4f5c3043-976d-4a86-a4f2-b3deee68f392"
  profile = "bx2-2x8"
  resource_group = data.ibm_resource_group.resourceGroup.id
  primary_network_interface {
    subnet = ibm_is_subnet.vpc_subnet[0].id
    allow_ip_spoofing = false
  }
  vpc = ibm_is_vpc.vpc_vm.id
  zone = var.zones[0]
  keys = var.windows_key
  tags = var.tags
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

