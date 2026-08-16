module "almalinux_template" {
  source = "./modules"

  name      = "ci-almalinux-9"
  vm_id     = 900
  node_name = var.node_name

  datastore_id          = var.datastore_id
  download_datastore_id = var.download_datastore_id
  network_bridge        = var.network_bridge

  image_url       = "https://repo.almalinux.org/almalinux/10/cloud/x86_64/images/AlmaLinux-10-GenericCloud-latest.x86_64.qcow2"
  image_file_name = "almalinux-10-genericcloud-amd64.qcow2"
}


module "debian_template" {
  source = "./modules"

  name      = "ci-debian-12"
  vm_id     = 901
  node_name = var.node_name

  datastore_id          = var.datastore_id
  download_datastore_id = var.download_datastore_id
  network_bridge        = var.network_bridge

  image_url       = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-arm64.qcow2"
  image_file_name = "debian-13-generic-amd64.qcow2"
}

module "fedora_template" {
  source = "./modules"

  name      = "ci-fedora-44"
  vm_id     = 902
  node_name = var.node_name

  datastore_id          = var.datastore_id
  download_datastore_id = var.download_datastore_id
  network_bridge        = var.network_bridge

  # Fedora release numbers change often — check
  # https://fedoraproject.org/cloud/download for the current release URL.
  image_url       = "https://download.fedoraproject.org/pub/fedora/linux/releases/44/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2"
  image_file_name = "fedora-44-generic-amd64.qcow2"
}

module "ubuntu_template" {
  source = "./modules"

  name      = "ci-ubuntu-24.04"
  vm_id     = 903
  node_name = var.node_name

  datastore_id          = var.datastore_id
  download_datastore_id = var.download_datastore_id
  network_bridge        = var.network_bridge

  image_url       = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  image_file_name = "noble-server-cloudimg-amd64.qcow2"
}