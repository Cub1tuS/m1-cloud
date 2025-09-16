# V. Azure Vault

## 1. Lil' intro ?

**L'idée d'une *Vault* est donc de proposer un endroit centralisé et sécurisé où stocker ces *secrets*.**

On peut ensuite accéder à ces *secrets* après authentification (lecture/écriture). Souvent ça passe par le protocole HTTP (une API REST quoi) pour la plupart des *Vaults*.

➜ Azure propose une *Vault*, permettant de partager des *secrets* entre plusieurs VMs ou ressources. 

Et avec Terraform, on peut les définir à la volée de façon **aléatoire**, ou les **prédéfinir manuellement**.

## 2. Do it !

🌞 **Compléter votre plan Terraform et mettez en place une *Azure Key Vault***

[Fichier Keyault](../terraform/keyvault.tf)

## 3. Proof proof proof

🌞 **Avec une commande `az`, afficher le *secret***

```
dorian@Air-de-Dorian terraform % az keyvault secret show \
  --name example-secret \
  --vault-name kv-tf-cloud-tp1 \
  --query value \
  --output tsv
R$!c:q&=DuP#dcPsbaiho{Fn[bH#)@wa
```

> Première et dernière fois le fait d'afficher un secret en clair 😅

🌞 **Depuis la VM, afficher le secret**

```
dorian@super-vm:~$ cat tmp.sh 
#!/bin/bash

# Variables
KEYVAULT_NAME="kv-tf-cloud-tp1"
SECRET_NAME="example-secret"
KV_URL="https://${KEYVAULT_NAME}.vault.azure.net"

# Token via MI
ACCESS_TOKEN=$(curl -s "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net" -H "Metadata:true" | jq -r '.access_token')

# Récupération du secret
SECRET_VALUE=$(curl -s "${KV_URL}/secrets/${SECRET_NAME}?api-version=7.3" -H "Authorization: Bearer ${ACCESS_TOKEN}" | jq -r '.value')

echo "Valeur du secret : $SECRET_VALUE"
```