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

- je vous recommande de créer un nouveau fichier `storage.tf` à côté de votre `main.tf`

📁 **Fichiers attendus**

- `main.tf`
- `storage.tf`
- tout autre fichier Terraform utilisé

## Help : Exemple de fichier Terraform

??? example

    Un fichier qui fait une bonne partie du taf :
    ```tf
    # storage.tf
    
    resource "azurerm_storage_account" "main" {
      name                     = var.storage_account_name
      resource_group_name      = azurerm_resource_group.main.name
      location                 = azurerm_resource_group.main.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
    
    resource "azurerm_storage_container" "meowcontainer" {
      name                  = var.storage_container_name
      storage_account_id = azurerm_storage_account.main.id
      container_access_type = "private"
    }
    
    data "azurerm_virtual_machine" "main" {
      name                = azurerm_linux_virtual_machine.main.name
      resource_group_name = azurerm_resource_group.main.name
    }
    
    resource "azurerm_role_assignment" "vm_blob_access" {
      principal_id = data.azurerm_virtual_machine.main.identity[0].principal_id
      role_definition_name = "Storage Blob Data Contributor"
      scope                = azurerm_storage_account.main.id
    
      depends_on = [
        azurerm_linux_virtual_machine.main
      ]
    }
    ```

## 3. Proooooooofs

🌞 **Prouvez que tout est bien configuré, depuis la VM Azure**

- installez `azcopy` dans la VM (suivez [la doc officielle](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10?tabs=apt) pour l'installer dans votre VM Azure)
- `azcopy login --identity` pour vous authentifier automatiquement
- utilisez `azcopy` pour écrire un fichier dans le *Storage Container* que vous avez créé
- utilisez `azcopy` pour lire le fichier que vous venez de push

???+ note

    On peut facilement imaginer un service/script de backup qui tourne sur la VM.  
    Il pourrait upload de façon sécurisé la backup résultante sur le Blob Storage de Azure.

🌞 **Déterminez comment `azcopy login --identity` vous a authentifié**

- une ptite short explication (t'façon c'est GPT qui va l'écrire non ?)
- juste que vous sachiez un minimum comment fonctionne le machin, y'a du JWT derrière notamment

![Didn't expect that](../../assets/img/meme_didnt_expect_that.png)

🌞 **Requêtez un JWT d'authentification auprès du service que vous venez d'identifier, manuellement**

- depuis la VM
- avec une commande `curl`
- à priori ce sera une requête vers `169.254.169.254`

🌞 **Expliquez comment l'IP `169.254.169.254` peut être joignable**

- petit hint : table de routage de la VM !
