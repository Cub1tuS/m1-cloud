# II. Network Security Group

## 1. Ptite intro

Un **Network Security Group** ou ***NSG*** for short, c'est *un genre de firewall* géré par Azure.

On peut affecter un *NSG* à une interface réseau.

En configurant ce *NSG*, on pourra alors faire du filtrage réseau, comme par exemple : n'autoriser les connexions que sur un certain port.

???+ note

    Pour rappel, on repart de ce que vous savez déployé avec le TP1.

## 2. Ajouter un NSG au déploiement

???+ danger

    Si vous faites le TP à l'école, on parle donc de l'IP publique du routeur de l'école.  
    Si c'est chez vous, ce sera celle de votre box.  
    **Il serait bien avisé de masquer cette IP dans le compte-rendu de TP public que vous me remettez.**  

🌞 **[Ajouter un NSG à votre déploiement Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)**

- le trafic qui arrive sur l'interface réseau de la VM qui porte l'IP publique doit être filtré :

    - n'autorise les connexions que sur le port 22 (pour SSH)
    - n'autorise les connexions que depuis votre IP publique

- je vous recommande de créer un nouveau fichier `network.tf` à côté de votre `main.tf` et y mettre cette conf

???+ note

    Aucun include nécessaire ou quoi.  
    Si le fichier se termine par `.tf`, il sera lu par vos commandes `terraform`.

## 3. Proofs !

🌞 **Prouver que ça fonctionne, rendu attendu :**

- la sortie du `terraform apply` (ce qu'affiche votre `output.tf`)
- une commande `az` pour obtenir toutes les infos liées à la VM

    - on doit y voir le *NSG*

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