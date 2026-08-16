output "template_vm_ids" {
  description = "vmid of by distro"
  value = {
    almalinux = module.almalinux_template.vm_id
    debian    = module.debian_template.vm_id
    fedora    = module.fedora_template.vm_id
    ubuntu    = module.ubuntu_template.vm_id
  }
}