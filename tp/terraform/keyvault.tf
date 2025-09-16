# keyvault.tf

# Récupère les infos du client Azure
data "azurerm_client_config" "current" {}

# Génère une valeur secrète aléatoire
resource "random_password" "example" {
  length  = 32
  upper   = true
  lower   = true
  numeric = true
  special = true
}

# Création du Key Vault
resource "azurerm_key_vault" "main" {
  name                        = "kv-${var.resource_group_name}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }
}

# Stocke le secret aléatoire dans le Key Vault
resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = random_password.example.result
  key_vault_id = azurerm_key_vault.main.id
}