# II. Network Security Group

## 1. Ptite intro

Un **Network Security Group** ou ***NSG*** for short, c'est *un genre de firewall* géré par Azure.

On peut affecter un *NSG* à une interface réseau.

En configurant ce *NSG*, on pourra alors faire du filtrage réseau, comme par exemple : n'autoriser les connexions que sur un certain port.

???+ note

    Pour rappel, on repart de ce que vous savez déployé avec le TP1.

## 2. Ajouter un NSG au déploiement

🌞 **[Ajouter un NSG à votre déploiement Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)**

[Ajout du fichier network](../terraform/network.tf)

## 3. Proofs !

🌞 **Prouver que ça fonctionne, rendu attendu :**

- la sortie du `terraform apply`

```
Terraform will perform the following actions:

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
          + offer     = "0001-com-ubuntu-server-focal"
          + publisher = "Canonical"
          + sku       = "20_04-lts"
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
              + source_address_prefix                      = "***"
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
      + allocation_method       = "Dynamic"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "westeurope"
      + name                    = "vm-ip"
      + resource_group_name     = "tf-cloud-tp1"
      + sku                     = "Basic"
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
      + subnet                         = (known after apply)
    }
```

- une commande `az` pour obtenir toutes les infos liées à la VM

```
dorian@Air-de-Dorian terraform % az vm show --name "super-vm" --resource-group "tf-cloud-tp1" --output json
{
  "additionalCapabilities": null,
  "applicationProfile": null,
  "availabilitySet": null,
  "billingProfile": null,
  "capacityReservation": null,
  "diagnosticsProfile": {
    "bootDiagnostics": {
      "enabled": false,
      "storageUri": null
    }
  },
  "etag": "\"1\"",
  "evictionPolicy": null,
  "extendedLocation": null,
  "extensionsTimeBudget": "PT1H30M",
  "hardwareProfile": {
    "vmSize": "Standard_B1s",
    "vmSizeProperties": null
  },
  "host": null,
  "hostGroup": null,
  "id": "/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Compute/virtualMachines/super-vm",
  "identity": null,
  "instanceView": null,
  "licenseType": null,
  "location": "westeurope",
  "managedBy": null,
  "name": "super-vm",
  "networkProfile": {
    "networkApiVersion": null,
    "networkInterfaceConfigurations": null,
    "networkInterfaces": [
      {
        "deleteOption": null,
        "id": "/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/networkInterfaces/vm-nic",
        "primary": true,
        "resourceGroup": "tf-cloud-tp1"
      }
    ]
  },
  "osProfile": {
    "adminPassword": null,
    "adminUsername": "dorian",
    "allowExtensionOperations": true,
    "computerName": "super-vm",
    "customData": null,
    "linuxConfiguration": {
      "disablePasswordAuthentication": true,
      "enableVmAgentPlatformUpdates": null,
      "patchSettings": {
        "assessmentMode": "ImageDefault",
        "automaticByPlatformSettings": null,
        "patchMode": "ImageDefault"
      },
      "provisionVmAgent": true,
      "ssh": {
        "publicKeys": [
          {
            "keyData": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNmOB+s+ExbzivB2c73gHWR3CrcYBMMMgL6DXbkCT+g cloud_tp1\n",
            "path": "/home/dorian/.ssh/authorized_keys"
          }
        ]
      }
    },
    "requireGuestProvisionSignal": true,
    "secrets": [],
    "windowsConfiguration": null
  },
  "placement": null,
  "plan": null,
  "platformFaultDomain": null,
  "priority": "Regular",
  "provisioningState": "Succeeded",
  "proximityPlacementGroup": null,
  "resourceGroup": "tf-cloud-tp1",
  "resources": null,
  "scheduledEventsPolicy": null,
  "scheduledEventsProfile": null,
  "securityProfile": null,
  "storageProfile": {
    "alignRegionalDisksToVmZone": null,
    "dataDisks": [],
    "diskControllerType": null,
    "imageReference": {
      "communityGalleryImageId": null,
      "exactVersion": "20.04.202505200",
      "id": null,
      "offer": "0001-com-ubuntu-server-focal",
      "publisher": "Canonical",
      "sharedGalleryImageId": null,
      "sku": "20_04-lts",
      "version": "latest"
    },
    "osDisk": {
      "caching": "ReadWrite",
      "createOption": "FromImage",
      "deleteOption": "Detach",
      "diffDiskSettings": null,
      "diskSizeGb": 30,
      "encryptionSettings": null,
      "image": null,
      "managedDisk": {
        "diskEncryptionSet": null,
        "id": "/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Compute/disks/vm-os-disk",
        "resourceGroup": "tf-cloud-tp1",
        "securityProfile": null,
        "storageAccountType": "Standard_LRS"
      },
      "name": "vm-os-disk",
      "osType": "Linux",
      "vhd": null,
      "writeAcceleratorEnabled": false
    }
  },
  "tags": {},
  "timeCreated": "2025-09-14T14:14:02.867127+00:00",
  "type": "Microsoft.Compute/virtualMachines",
  "userData": null,
  "virtualMachineScaleSet": null,
  "vmId": "2dcd8d92-9d9d-4318-9b32-f43001094259",
  "zones": null
}
```

```
dorian@Air-de-Dorian terraform % az network nic show \
  --name vm-nic \
  --resource-group tf-cloud-tp1 \
  --query "networkSecurityGroup" \
  --output json
{
  "id": "/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/networkSecurityGroups/acceptanceTestSecurityGroup1",
  "resourceGroup": "tf-cloud-tp1"
}
```

- une commande `ssh` fonctionnelle 


```
dorian@Air-de-Dorian terraform % ssh dorian@4.180.66.125
The authenticity of host '4.180.66.125 (4.180.66.125)' can't be established.
ED25519 key fingerprint is SHA256:wKaKnE+52k/CMOf347Cr5GXJmP2nCYotk9FYTT0QKJ4.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '4.180.66.125' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)
```

- changement de port :


```
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2025-09-14 14:24:17 UTC; 3s ago
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 1713 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 1714 (sshd)
      Tasks: 1 (limit: 1063)
     Memory: 1.0M
     CGroup: /system.slice/ssh.service
             └─1714 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

Sep 14 14:24:17 super-vm systemd[1]: Starting OpenBSD Secure Shell server...
Sep 14 14:24:17 super-vm sshd[1714]: Server listening on 0.0.0.0 port 2222.
Sep 14 14:24:17 super-vm sshd[1714]: Server listening on :: port 2222.
Sep 14 14:24:17 super-vm systemd[1]: Started OpenBSD Secure Shell server.
```

```
root@super-vm:/home/dorian# ss -tlnp | grep sshd
LISTEN    0         128                0.0.0.0:2222             0.0.0.0:*        users:(("sshd",pid=1714,fd=3))                                                 
LISTEN    0         128                   [::]:2222                [::]:*        users:(("sshd",pid=1714,fd=4)) 
```

```
dorian@Air-de-Dorian terraform % ssh dorian@51.144.244.188
ssh: connect to host 51.144.244.188 port 22: Connection refused
```

📁 **Fichiers attendus**

- `main.tf`
- `network.tf`
- tout autre fichier Terraform utilisé