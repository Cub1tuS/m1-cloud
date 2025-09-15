# III. Blob storage

## 1. Intro

➜ **Azure propose du Blob Storage**.

Dans cette section, vous allez créer un *Azure Storage Container* pour profiter du Blob Storage Azure depuis votre VM.

La logique Azure est la suivante :

- il faut créer un *Storage Account*
- avec ce *Storage Account* vous pourrez créer des ***Storage Container***
- on peut accéder à ce *Storage Container* depuis nos VMs autorisées

➜ **Une fois qu'une VM a accès à un Storage Container, elle peut écrire/lire des fichiers arbitrairement dedans.**

Vous verrez qu'on peut **appliquer une politique d'accès et d'authentification** qui permet de définir qui peut accéder à notre Storage Container.

## 2. Let's go

🌞 **Compléter votre plan Terraform pour déployer du Blob Storage pour votre VM**

[Fichier Storage](../terraform/storage.tf)

```
random_integer.suffix: Creating...
random_integer.suffix: Creation complete after 0s [id=85118]
azurerm_resource_group.main: Creating...
azurerm_resource_group.main: Still creating... [00m10s elapsed]
azurerm_resource_group.main: Creation complete after 10s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1]
azurerm_virtual_network.main: Creating...
azurerm_public_ip.main: Creating...
azurerm_network_security_group.main: Creating...
azurerm_storage_account.main: Creating...
azurerm_network_security_group.main: Creation complete after 3s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/networkSecurityGroups/acceptanceTestSecurityGroup1]
azurerm_public_ip.main: Creation complete after 5s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/publicIPAddresses/vmPublicIP]
azurerm_virtual_network.main: Creation complete after 6s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/virtualNetworks/vm-vnet]
azurerm_subnet.main: Creating...
azurerm_storage_account.main: Still creating... [00m10s elapsed]
azurerm_subnet.main: Creation complete after 7s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
azurerm_network_interface.main: Creating...
azurerm_storage_account.main: Still creating... [00m20s elapsed]
azurerm_network_interface.main: Still creating... [00m10s elapsed]
azurerm_network_interface.main: Creation complete after 11s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/networkInterfaces/vm-nic]
azurerm_network_interface_security_group_association.main: Creating...
azurerm_linux_virtual_machine.main: Creating...
azurerm_storage_account.main: Still creating... [00m30s elapsed]
azurerm_network_interface_security_group_association.main: Still creating... [00m10s elapsed]
azurerm_linux_virtual_machine.main: Still creating... [00m10s elapsed]
azurerm_network_interface_security_group_association.main: Creation complete after 12s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/networkInterfaces/vm-nic|/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Network/networkSecurityGroups/acceptanceTestSecurityGroup1]
azurerm_storage_account.main: Still creating... [00m40s elapsed]
azurerm_linux_virtual_machine.main: Creation complete after 19s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Compute/virtualMachines/super-vm]
data.azurerm_virtual_machine.main: Reading...
data.azurerm_virtual_machine.main: Read complete after 0s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Compute/virtualMachines/super-vm]
azurerm_storage_account.main: Still creating... [00m50s elapsed]
azurerm_storage_account.main: Still creating... [01m00s elapsed]
azurerm_storage_account.main: Creation complete after 1m9s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Storage/storageAccounts/lol16869861]
azurerm_role_assignment.vm_blob_access: Creating...
azurerm_storage_container.super_container: Creating...
azurerm_storage_container.super_container: Creation complete after 1s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Storage/storageAccounts/lol16869861/blobServices/default/containers/mdr17171789717]
azurerm_role_assignment.vm_blob_access: Still creating... [00m10s elapsed]
azurerm_role_assignment.vm_blob_access: Still creating... [00m20s elapsed]
azurerm_role_assignment.vm_blob_access: Creation complete after 27s [id=/subscriptions/2c1a3857-ab2c-454b-92f8-053d0a5b9f15/resourceGroups/tf-cloud-tp1/providers/Microsoft.Storage/storageAccounts/lol16869861/providers/Microsoft.Authorization/roleAssignments/6c5e041f-880f-a8a5-8307-8d43549bedc3]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

vm_public_fqdn = "tfcloudtp1-vm.westeurope.cloudapp.azure.com"
vm_public_ip = "108.142.152.49"
```

📁 **Fichiers attendus**

- `main.tf`
- `storage.tf`
- tout autre fichier Terraform utilisé

## 3. Proooooooofs

🌞 **Prouvez que tout est bien configuré, depuis la VM Azure**

- installez `azcopy` dans la VM (suivez [la doc officielle](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10?tabs=apt) pour l'installer dans votre VM Azure)
- `azcopy login --identity` pour vous authentifier automatiquement
- utilisez `azcopy` pour écrire un fichier dans le *Storage Container* que vous avez créé
- utilisez `azcopy` pour lire le fichier que vous venez de push

🌞 **Déterminez comment `azcopy login --identity` vous a authentifié**

- une ptite short explication (t'façon c'est GPT qui va l'écrire non ?)
- juste que vous sachiez un minimum comment fonctionne le machin, y'a du JWT derrière notamment

🌞 **Requêtez un JWT d'authentification auprès du service que vous venez d'identifier, manuellement**

- depuis la VM
- avec une commande `curl`
- à priori ce sera une requête vers `169.254.169.254`

🌞 **Expliquez comment l'IP `169.254.169.254` peut être joignable**

- petit hint : table de routage de la VM !
