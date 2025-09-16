# V. Azure Vault

## 1. Lil' intro ?

**L'idée d'une *Vault* est donc de proposer un endroit centralisé et sécurisé où stocker ces *secrets*.**

On peut ensuite accéder à ces *secrets* après authentification (lecture/écriture). Souvent ça passe par le protocole HTTP (une API REST quoi) pour la plupart des *Vaults*.

➜ Azure propose une *Vault*, permettant de partager des *secrets* entre plusieurs VMs ou ressources. 

Et avec Terraform, on peut les définir à la volée de façon **aléatoire**, ou les **prédéfinir manuellement**.

## 2. Do it !

🌞 **Compléter votre plan Terraform et mettez en place une *Azure Key Vault***

[Fichier Keyault](../terraform/keyvault.tf)

## Help : Exemple de fichiers Terraform

- Il faut créer un *Azure Key Vault* et donner à votre VM les droits dessus

??? example

    ```tf
    resource "azurerm_key_vault" "meow_vault" {
      name                       = "<Le nom de ta Azure Key Vault ici>"
      location                   = azurerm_resource_group.main.location
      resource_group_name        = azurerm_resource_group.main.name
      tenant_id                  = data.azurerm_client_config.current.tenant_id
      sku_name                   = "standard"
      soft_delete_retention_days = 7
      purge_protection_enabled   = false
    
      access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id
        secret_permissions = [
          "Get", "List", "Set", "Delete", "Purge", "Recover"
        ]
      }
    
      access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = azurerm_linux_virtual_machine.main.identity[0].principal_id
        secret_permissions = [
          "Get", "List"
        ]
      }
    }
    ```

- Terraform peut générer des strings random, y'a une ressource dédiée à ça

??? example

    ```tf
    # 16 caractères, en remplaçant certains caractères qu'on veut pas
    resource "random_password" "meow_secret" {
      length           = 16
      special          = true
      override_special = "@#$%^&*()"
    }
    ```

- On peut ensuite récupérer la valeur dans une autre ressource

??? example

    ```tf
    # au hasard, pour créer un Secret dans une Azure Key Vault :)
    resource "azurerm_key_vault_secret" "meow_secret" {
      name         = "<Le nom de ton secret ici>"
      value        = random_password.meow_secret.result
      key_vault_id = azurerm_key_vault.meow_vault.id
    }
    ```

- **vous pouvez alors voir dans la WebUI Azure si vous voulez :**

    - dans `Key vaults` > `Le nom de ta Azure Key Vault` > `Secrets` > `Le nom de ton secret` > `Current version` > `Show Secret value`

## 3. Proof proof proof

🌞 **Avec une commande `az`, afficher le *secret***

- depuis votre poste, et votre compte Azure, vous avez les droits pour voir le *secret* normalement
- ça va se faire avec un `az keyvault secret show --name "<Le nom de ton secret ici>" --vault-name "<Le nom de ta Azure Key Vault ici>"`

🌞 **Depuis la VM, afficher le secret**

- il faut donc faire une requête à la Azure Key Vault depuis la VM Azure
- un ptit script shell ça le fait !

???+ note

    En situation réelle, ce serait l'application qui a besoin de ce *secret* qui effecturait la requête.  
    Si c'est pour templater un fichier de conf, on imagine facilement un Ansible, cloud-init, ou équivalent qui se charge de ça !

![GG EZ](../../assets/img/meme_gg_ez.png)