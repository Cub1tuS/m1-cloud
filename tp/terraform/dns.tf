resource "azurerm_public_ip" "main" {
  name                = "vmPublicIP"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  domain_name_label   = "tfcloudtp1-vm"
}

resource "azurerm_network_interface" "main" {
  name                = "vm-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

output "vm_public_fqdn" {
  value = azurerm_public_ip.main.fqdn
  description = "FQDN de la VM pour connexion SSH"
}
