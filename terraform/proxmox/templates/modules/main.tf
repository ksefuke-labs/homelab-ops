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
  bios    = "ovmf"

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  efi_disk {
    datastore_id      = var.datastore_id
    file_format       = "raw"
    type              = "4m"
    pre_enrolled_keys = false
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = proxmox_download_file.cloud_image.id
    interface    = "scsi0"
    iothread     = true
    ssd          = true
    discard      = "on"
    file_format  = "raw"
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

  # Serial console is commonly needed for cloud images to boot/log correctly
  serial_device {}

  vga {
    type = "serial0"
  }

  # Intentionally left unconfigured (no user_account / ip_config) — this is
  # a template. Set those per-clone when you create actual VMs from it.
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