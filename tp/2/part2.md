# II. Un ptit nom DNS

Waddabout donner un ptit nom DNS à notre VM ?

## 1. Adapter le plan Terraform

🌞 **Donner un nom DNS à votre VM**

- avec Terraform, [suffit d'ajouter une propriété `domain_name_label` sur la ressource `azurerm_public_ip`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#domain_name_label-1)

- go `terraform apply` après !

```

  # azurerm_linux_virtual_machine.main will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_username                                         = "dorian"
      + allow_extension_operations                             = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = (known after apply)
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "westeurope"
      + max_bid_price                                          = -1
      + name                                                   = "super-vm"
      + network_interface_ids                                  = (known after apply)
      + os_managed_disk_id                                     = (known after apply)
      + patch_assessment_mode                                  = (known after apply)
      + patch_mode                                             = (known after apply)
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = (known after apply)
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "tf-cloud-tp1"
      + size                                                   = "Standard_B1s"
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNmOB+s+ExbzivB2c73gHWR3CrcYBMMMgL6DXbkCT+g cloud_tp1
            EOT
          + username   = "dorian"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + id                        = (known after apply)
          + name                      = "vm-os-disk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "debian-11"
          + publisher = "Debian"
          + sku       = "11"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

  # azurerm_network_interface.main will be created
  + resource "azurerm_network_interface" "main" {
      + accelerated_networking_enabled = false
      + applied_dns_servers            = (known after apply)
      + id                             = (known after apply)
      + internal_domain_name_suffix    = (known after apply)
      + ip_forwarding_enabled          = false
      + location                       = "westeurope"
      + mac_address                    = (known after apply)
      + name                           = "vm-nic"
      + private_ip_address             = (known after apply)
      + private_ip_addresses           = (known after apply)
      + resource_group_name            = "tf-cloud-tp1"
      + virtual_machine_id             = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "internal"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_interface_security_group_association.main will be created
  + resource "azurerm_network_interface_security_group_association" "main" {
      + id                        = (known after apply)
      + network_interface_id      = (known after apply)
      + network_security_group_id = (known after apply)
    }

  # azurerm_network_security_group.main will be created
  + resource "azurerm_network_security_group" "main" {
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "acceptanceTestSecurityGroup1"
      + resource_group_name = "tf-cloud-tp1"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "test123"
              + priority                                   = 100
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "172.226.148.60"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
                # (1 unchanged attribute hidden)
            },
        ]
    }

  # azurerm_public_ip.main will be created
  + resource "azurerm_public_ip" "main" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + domain_name_label       = "tfcloudtp1-vm"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "westeurope"
      + name                    = "vmPublicIP"
      + resource_group_name     = "tf-cloud-tp1"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
    }

  # azurerm_resource_group.main will be created
  + resource "azurerm_resource_group" "main" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "tf-cloud-tp1"
    }

  # azurerm_subnet.main will be created
  + resource "azurerm_subnet" "main" {
      + address_prefixes                              = [
          + "10.0.1.0/24",
        ]
      + default_outbound_access_enabled               = true
      + id                                            = (known after apply)
      + name                                          = "vm-subnet"
      + private_endpoint_network_policies             = "Disabled"
      + private_link_service_network_policies_enabled = true
      + resource_group_name                           = "tf-cloud-tp1"
      + virtual_network_name                          = "vm-vnet"
    }

  # azurerm_virtual_network.main will be created
  + resource "azurerm_virtual_network" "main" {
      + address_space                  = [
          + "10.0.0.0/16",
        ]
      + dns_servers                    = (known after apply)
      + guid                           = (known after apply)
      + id                             = (known after apply)
      + location                       = "westeurope"
      + name                           = "vm-vnet"
      + private_endpoint_vnet_policies = "Disabled"
      + resource_group_name            = "tf-cloud-tp1"
      + subnet                         = (known after app
```

[Fichier DNS](../terraform/dns.tf)

## 2. Ajouter un output custom à `terraform apply`

🌞 **Un ptit output nan ?**

- créez un fichier `outputs.tf` à côté de votre `main.tf`
- doit afficher l'IP publique et le nom DNS de la VM

[Fichier Outputs](../terraform/outputs.tf)

## 3. Proooofs ! 

🌞 **Proofs ! Donnez moi :**

- la sortie du `terraform apply` (ce qu'affiche votre `outputs.tf`)

```
Outputs:

vm_public_fqdn = "tfcloudtp1-vm.westeurope.cloudapp.azure.com"
vm_public_ip = "172.201.193.39"
```

- une commande `ssh` fonctionnelle vers le nom de domaine (pas l'IP)

```
dorian@Air-de-Dorian terraform % ssh dorian@tfcloudtp1-vm.westeurope.cloudapp.azure.com
The authenticity of host 'tfcloudtp1-vm.westeurope.cloudapp.azure.com (172.201.10.4)' can't be established.
ED25519 key fingerprint is SHA256:aTQQqTH1vzxSSKcQ9nCjt1wdbEy5tyIZCU+8wcAYRyQ.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:282: 172.201.10.4
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'tfcloudtp1-vm.westeurope.cloudapp.azure.com' (ED25519) to the list of known hosts.
Linux super-vm 5.10.0-35-cloud-amd64 #1 SMP Debian 5.10.237-1 (2025-05-19) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Sep 14 21:58:45 2025 from 176.136.90.169
dorian@super-vm:~$ 
```

📁 **Fichiers attendus**

- `outputs.tf`
- `main.tf`
- tout autre fichier Terraform utilisé

[Partie 3](part3.md)