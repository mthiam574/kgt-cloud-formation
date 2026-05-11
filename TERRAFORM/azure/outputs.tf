output "container_ip" {
  description = "IP publique du conteneur"
  value       = azurerm_container_group.kgt_app.ip_address
}

output "container_name" {
  description = "Nom du conteneur"
  value       = azurerm_container_group.kgt_app.name
}
