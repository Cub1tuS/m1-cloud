# II. Un ptit nom DNS

Waddabout donner un ptit nom DNS à notre VM ?

## 1. Adapter le plan Terraform

🌞 **Donner un nom DNS à votre VM**

- avec Terraform, [suffit d'ajouter une propriété `domain_name_label` sur la ressource `azurerm_public_ip`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#domain_name_label-1)
- go `terraform apply` après !

[Fichier DNS](../terraform/dns.tf)

## 2. Ajouter un output custom à `terraform apply`

🌞 **Un ptit output nan ?**

- créez un fichier `outputs.tf` à côté de votre `main.tf`
- doit afficher l'IP publique et le nom DNS de la VM

## 3. Proooofs ! 

🌞 **Proofs ! Donnez moi :**

- la sortie du `terraform apply` (ce qu'affiche votre `outputs.tf`)
- une commande `ssh` fonctionnelle vers le nom de domaine (pas l'IP)

    - vers le nom de domaine de la publique
    - toujours sans mot de passe avec votre Agent SSH

???+ note

    A partir de maintenant, vous n'utiliserez que le nom de domaine de la VM pour la contacter (plus l'IP publique).

📁 **Fichiers attendus**

- `outputs.tf`
- `main.tf`
- tout autre fichier Terraform utilisé