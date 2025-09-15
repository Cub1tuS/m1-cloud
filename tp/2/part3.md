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

```
dorian@super-vm:~$ azcopy login --identity
INFO: Login with identity succeeded.
```

```
dorian@super-vm:~$ azcopy copy test.txt 'https://lol87688.blob.core.windows.net/mdr868554'
NFO: Scanning...
INFO: Autologin not specified.
INFO: Authenticating to destination using Azure AD
INFO: Any empty folders will not be processed, because source and/or destination doesn't have full folder support

Job ade49cee-ccfd-1a48-7af1-a0f16c9a72d5 has started
Log file is located at: /home/dorian/.azcopy/ade49cee-ccfd-1a48-7af1-a0f16c9a72d5.log

100.0 %, 1 Done, 0 Failed, 0 Pending, 0 Skipped, 1 Total, 2-sec Throughput (Mb/s): 0


Job ade49cee-ccfd-1a48-7af1-a0f16c9a72d5 summary
Elapsed Time (Minutes): 0.0336
Number of File Transfers: 1
Number of Folder Property Transfers: 0
Number of Symlink Transfers: 0
Total Number of Transfers: 1
Number of File Transfers Completed: 1
Number of Folder Transfers Completed: 0
Number of File Transfers Failed: 0
Number of Folder Transfers Failed: 0
Number of File Transfers Skipped: 0
Number of Folder Transfers Skipped: 0
Number of Symbolic Links Skipped: 0
Number of Hardlinks Converted: 0
Number of Special Files Skipped: 0
Total Number of Bytes Transferred: 4
Final Job Status: Completed
```

```
dorian@super-vm:~$ azcopy copy 'https://lol87688.blob.core.windows.net/mdr868554/test.txt' . && cat test.txt
INFO: Scanning...
INFO: Autologin not specified.
INFO: Authenticating to source using Azure AD
INFO: Any empty folders will not be processed, because source and/or destination doesn't have full folder support

Job 935c4142-687c-bd46-4e95-f1d407afc4ca has started
Log file is located at: /home/dorian/.azcopy/935c4142-687c-bd46-4e95-f1d407afc4ca.log

100.0 %, 1 Done, 0 Failed, 0 Pending, 0 Skipped, 1 Total, 2-sec Throughput (Mb/s): 0


Job 935c4142-687c-bd46-4e95-f1d407afc4ca summary
Elapsed Time (Minutes): 0.0334
Number of File Transfers: 1
Number of Folder Property Transfers: 0
Number of Symlink Transfers: 0
Total Number of Transfers: 1
Number of File Transfers Completed: 1
Number of Folder Transfers Completed: 0
Number of File Transfers Failed: 0
Number of Folder Transfers Failed: 0
Number of File Transfers Skipped: 0
Number of Folder Transfers Skipped: 0
Number of Symbolic Links Skipped: 0
Number of Hardlinks Converted: 0
Number of Special Files Skipped: 0
Total Number of Bytes Transferred: 4
Final Job Status: Completed

meo
```

🌞 **Déterminez comment `azcopy login --identity` vous a authentifié**

- une ptite short explication (t'façon c'est GPT qui va l'écrire non ?)
- juste que vous sachiez un minimum comment fonctionne le machin, y'a du JWT derrière notamment

- D'après ChatGPT 😶 :

```
	•	AzCopy appelle l’endpoint de l’instance Azure Managed Identity (MSI) rattachée à la VM, App Service ou autre ressource.
	•	Cet endpoint renvoie un token JWT d’accès émis par Azure AD.
	•	Ce token est ensuite utilisé comme Bearer token dans les requêtes HTTP vers le service de stockage (Blob, Files, etc.).
	•	Le service vérifie le JWT (signature, audience, scope) et accorde l’accès si les permissions RBAC sont correctes.

En résumé : pas de mot de passe ni clé de stockage, juste un JWT fourni par l’identité managée et validé côté Azure.
```


🌞 **Requêtez un JWT d'authentification auprès du service que vous venez d'identifier, manuellement**

```
dorian@super-vm:~$ curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/' \
     -H 'Metadata: true'
{"access_token":"*****","client_id":"***","expires_in":"86400","expires_on":"1758063755","ext_expires_in":"86399","not_before":"1757977055","resource":"https://storage.azure.com/","token_type":"Bearer"}
```

🌞 **Expliquez comment l'IP `169.254.169.254` peut être joignable**

- C'est une IP présent dans la table de routage de la VM, l'IP est utilisé commme endpoint de métadonnées. (Service IMDS d'Azure dans ce cas)

[Partie 4](part4.md)