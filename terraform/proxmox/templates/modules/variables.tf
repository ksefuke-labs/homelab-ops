variable "name" {
  description = "Template VM name"
  type        = string
}

variable "vm_id" {
  type        = number
}

variable "node_name" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "download_datastore_id" {
  type = string
}

variable "network_bridge" {
  type = string
}

variable "image_url" {
  type        = string
}

variable "image_file_name" {
  type        = string
}

variable "checksum" {
  type        = string
  default     = null
}

variable "checksum_algorithm" {
  type    = string
  default = null
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "cpu_cores" {
  type    = number
  default = 2
}

variable "cpu_type" {
  type    = string
  default = "x86-64-v2-AES"
}

variable "memory" {
  type    = number
  default = 2048
}

variable "tags" {
  type    = list(string)
  default = ["template", "cloud-init"]
}