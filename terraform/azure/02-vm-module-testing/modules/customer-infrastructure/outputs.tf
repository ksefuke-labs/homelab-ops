output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.customer.name
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.customer.ip_address
}

output "postgres_fqdn" {
  description = "FQDN of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.customer.fqdn
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.customer.ip_address}"
}
