output "vm_public_ip" {
  description = "IP publique de la VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_public_fqdn" {
  description = "DNS de la VM"
  value       = azurerm_public_ip.main.fqdn
}
