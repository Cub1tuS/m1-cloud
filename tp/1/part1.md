# I. Prérequis

## 1. Starting blocks

➜  **Activez votre compte Azure for Students**

- en utilisant vos identifiants EFREI
- c'est [**ICI**](https://azure.microsoft.com/fr-fr/free/students)
- tu cliques sur le gros bouton vert et tu suis le guide Microsoft

➜ **Installer le Azure CLI `az` sur votre poste**

- [suivez la doc officielle](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

➜ **Installer Terraform sur votre poste**

- [suivez la doc officielle](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## 2. Une paire de clés SSH

On parle dans cette section uniquement de **votre paire de clés** à générer **depuis votre poste**, pour sécuriser vos connexions SSH

Ha et on va aussi **configurer un Agent SSH.**

ON VA BOSSER CORRECTEMENT QUOI 🌻

### A. Choix de l'algorithme de chiffrement

🌞 **Déterminer quel algorithme de chiffrement utiliser pour vos clés**

- **vous n'utiliserez PAS RSA**
- donner une [source fiable](https://www.openssh.com/txt/release-8.8) qui explique pourquoi on évite RSA désormais (pour les connexions SSH notamment)
- donner une [source fiable](https://www.openssh.com/specs.html) qui recommande un autre algorithme de chiffrement (pour les connexions SSH notamment)

### B. Génération de votre paire de clés

🌞 **Générer une paire de clés pour ce TP**

- la clé privée doit s'appeler `cloud_tp1`
- elle doit se situer dans le dossier standard pour votre utilisateur
- elle doit utiliser l'algorithme que vous avez choisi à l'étape précédente (donc, pas de RSA)
- elle est protégée par un mot de passe de votre choix

```
ssh-keygen -t ed25519 -f ~/.ssh/cloud_tp1 -C "cloud_tp1" -N "***"
```

### C. Agent SSH

Afin de ne pas systématiquement saisir le mot de passe d'une clé à chaque fois qu'on l'utilise, **parce que c'est très très chiant**, on peut utiliser un **Agent SSH**.

Un programme qui tourne en fond, auquel on ajoute nos clés SSH, qui peuvent ensuite être utilisée dès qu'on fait une connexion SSH.

L'avantage est qu'on ne saisit le password qu'au moment de l'ajout de la clé SSH à l'agent !

🌞 **Configurer un agent SSH sur votre poste**

- détaillez-moi toute la conf ici que vous aurez fait

```
dorian@Air-de-Dorian m1-cloud-az % ssh-add ~/.ssh/cloud_tp1
Enter passphrase for /Users/dorian/.ssh/cloud_tp1: 
Identity added: /Users/dorian/.ssh/cloud_tp1 (cloud_tp1)
dorian@Air-de-Dorian m1-cloud-az % ssh-add -l
256 SHA256:0UnKfCwhQ/ETiN6Yf9uiYjrXruX4Bx7ZK//YljmZC5k cloud_tp1 (ED25519)
```

[Partie 2](part2.md)