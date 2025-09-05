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

```
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
              + source_address_prefix                      = "104.28.30.16"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
                # (1 unchanged attribute hidden)
            },
        ]
    }
```

```
dorian@Air-de-Dorian terraform % ssh dorian@4.180.66.125
The authenticity of host '4.180.66.125 (4.180.66.125)' can't be established.
ED25519 key fingerprint is SHA256:wKaKnE+52k/CMOf347Cr5GXJmP2nCYotk9FYTT0QKJ4.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '4.180.66.125' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)
```

- une commande `ssh` fonctionnelle 

    - vers le nom de domaine attribué à la VM
    - toujours sans mot de passe avec votre Agent SSH

- changement de port :

    - modifiez le port d'écoute du serveur OpenSSH sur la VM pour le port 2222/tcp
    - prouvez que le serveur OpenSSH écoute sur ce nouveau port (avec une commande `ss` sur la VM)
    - prouvez qu'une nouvelle connexion sur ce port 2222/tcp ne fonctionne pas à cause du *NSG*

📁 **Fichiers attendus**

- `main.tf`
- `network.tf`
- tout autre fichier Terraform utilisé