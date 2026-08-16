# ---------------------------------------------------------------------------
# Secrets — populate these in terraform.tfvars (gitignored)
# ---------------------------------------------------------------------------
variable "proxmox_endpoint" {
  description = "Proxmox VE URL"
  type        = string
}

variable "proxmox_api_token" {
  description = "API token in the form user@realm!token-name=token-secret"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS certificate verification"
  type        = bool
  default     = false
}

variable "node_name" {
  type        = string
}

variable "datastore_id" {
  description = "Datastore for VM disks and the EFI disk"
  type        = string
  default     = "pve01-p1lp"
}

variable "download_datastore_id" {
  description = "Datastore used to store downloaded images"
  type        = string
  default     = "vm-images"
}

variable "network_bridge" {
  type        = string
  default     = "vmbr0"
}