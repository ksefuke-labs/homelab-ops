terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

# Customer 1: Black Dynamite
module "black-dynamite" {
  source = "./modules/customer-infrastructure"
  customer_name           = "black-dynamite"
  location                = "ukwest"
  vnet_cidr               = "10.1.0.0/16"
  ssh_public_key          = file("~/.ssh/id_rsa.pub")
  postgres_admin_password = "BDP@ssw0rd123!"
}

# Customer 2: Fiendish-doctor-wu
#module "fiendish-doctor-wu" {
#  source = "./modules/customer-infrastructure"
#
#  customer_name           = "fiendish-doctor-wu"
#  location                = "uksouth"
#  vnet_cidr               = "10.2.0.0/16"
#  ssh_public_key          = file("~/.ssh/id_rsa.pub")
#  postgres_admin_password = "FDWP@ssw0rd123!"
#}

# Outputs for Customer 1
output "black-dynamite_vm_ip" {
  description = "BD VM public IP"
  value       = module.black-dynamite.vm_public_ip
}

output "black-dynamite_ssh" {
  description = "BD SSH connection"
  value       = module.black-dynamite.ssh_connection
}

output "black-dynamite_postgres" {
  description = "BD PostgreSQL FQDN"
  value       = module.black-dynamite.postgres_fqdn
}

# # Outputs for Customer 2
# output "fiendish-doctor-wu_vm_ip" {
#   description = "Cicero VM public IP"
#   value       = module.cicero.vm_public_ip
# }
#
# output "fiendish-doctor-wu_ssh" {
#   description = "fiendish-doctor-wu connection"
#   value       = module.fiendish-doctor-wu.ssh_connection
# }
#
# output "fiendish-doctor-wu_postgres" {
#   description = "fiendish-doctor-wu PostgreSQL FQDN"
#   value       = module.fiendish-doctor-wu.postgres_fqdn
# }
