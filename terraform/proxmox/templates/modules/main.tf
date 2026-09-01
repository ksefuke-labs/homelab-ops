resource "proxmox_download_file" "cloud_image" {
  content_type = "import"
  datastore_id = var.download_datastore_id
  node_name    = var.node_name
  url          = var.image_url
  file_name    = var.image_file_name

  checksum           = var.checksum
  checksum_algorithm = var.checksum_algorithm

  overwrite           = true
  overwrite_unmanaged = true
}

resource "proxmox_virtual_environment_vm" "template" {
  name        = var.name
  node_name   = var.node_name
  vm_id       = var.vm_id
  description = "Cloud-init template (${var.name}) — managed by Terraform"
  tags        = var.tags

  template = true
  started  = false

  machine = "q35"
  bios    = "seabios"

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = proxmox_download_file.cloud_image.id
    interface    = "scsi0"
    ssd          = true
    discard      = "on"
    file_format  = "qcow2"
    size         = var.disk_size
  }

  scsi_hardware = "virtio-scsi-single"

  network_device {
    bridge = var.network_bridge
  }

  agent {
    enabled = true
    trim    = true
  }

  #serial_device {}

  #vga {
  #  type = "default"
  #}

  initialization {
    datastore_id = var.datastore_id
    interface    = "ide2"
  }

  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }
}