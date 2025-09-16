# II. Spawn des VMs

Pour tous les TPs avec Azure, lorsqu'il s'agit de VM, je vous laisse le choix de l'OS (un Linux quand même). Ce sera pas le coeur de notre sujet.

On commence avec la WebUI Azure ! ~~berk~~

## 1. Depuis la WebUI

➜ **Faites du cliclic partout dans la WebUI Azure pour créer une VM dans Azure.**

🌞 **Connectez-vous en SSH à la VM pour preuve**

```
dorian@Air-de-Dorian m1-cloud-az % ssh dorian@4.211.254.198
The authenticity of host '4.211.254.198 (4.211.254.198)' can't be established.
ED25519 key fingerprint is SHA256:8/D9tjfoZS9o020RtU/bONN3mrsusehIarxFnQrdIF0.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '4.211.254.198' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.11.0-1018-azure x86_64)
[...]
dorian@AZ-L001:~$ 
```

## 2. `az` : a programmatic approach

🌞 **Créez une VM depuis le Azure CLI**

```
az group create --location westeurope --name cloud-m1-az
```

```
az vm create \
  --resource-group cloud-m1-az \
  --name AZCLI-L001 \
  --image Ubuntu2204 \
  --size Standard_B2ats_v2
  --admin-username dorian \
  --ssh-key-values ~/.ssh/cloud_tp1.pub
```

🌞 **Assurez-vous que vous pouvez vous connecter à la VM en SSH sur son IP publique**

```
dorian@Air-de-Dorian ~ % ssh dorian@20.16.178.177
The authenticity of host '20.16.178.177 (20.16.178.177)' can't be established.
ED25519 key fingerprint is SHA256:bykjXoAeu534X+j/OIA7lfqsn+31u46pn7t9nwSlfvM.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.16.178.177' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1031-azure x86_64)
```

🌞 **Une fois connecté, prouvez la présence...**

- **...du service `walinuxagent.service`**

```
dorian@AZCLI-L001:~$ systemctl status walinuxagent.service
Warning: The unit file, source configuration file or drop-ins of walinuxagent.service chang>
● walinuxagent.service - Azure Linux Agent
     Loaded: loaded (/lib/systemd/system/walinuxagent.service; enabled; vendor preset: enab>
    Drop-In: /run/systemd/system.control/walinuxagent.service.d
             └─50-CPUAccounting.conf, 50-MemoryAccounting.conf
     Active: active (running) since Fri 2025-09-05 09:47:42 UTC; 3min 0s ago
```

- **...du service `cloud-init.service`**

```
dorian@AZCLI-L001:~$ systemctl status cloud-init
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/lib/systemd/system/cloud-init.service; enabled; vendor preset: enable>
     Active: active (exited) since Fri 2025-09-05 09:47:42 UTC; 3min 33s ago
   Main PID: 453 (code=exited, status=0/SUCCESS)
        CPU: 1.175s

Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |                 |
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |               . |
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |     .        o  |
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |    o ..S.   o   |
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |   . o..+o .. .  |
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |    o .+=.= .. + |
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |     =+* B.o *o =|
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: |    o.**Bo*=O+*=E|
Sep 05 09:47:41 AZCLI-L001 cloud-init[457]: +----[SHA256]-----+
Sep 05 09:47:42 AZCLI-L001 systemd[1]: Finished Cloud-init: Network Stage.
```

## 3. Terraforming ~~planets~~ infrastructures

🌞 **Utilisez Terraform pour créer une VM dans Azure**

[Liste des fichiers](./files/)

🌞 **Prouvez avec une connexion SSH sur l'IP publique que la VM est up**

```
dorian@Air-de-Dorian terraform % ssh dorian@98.71.167.185 
The authenticity of host '98.71.167.185 (98.71.167.185)' can't be established.
ED25519 key fingerprint is SHA256:/nHD96ArRIobfkyEklgr/c64xSZOPTgX4UsoWr5cCM0.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '98.71.167.185' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)
```

## 4. Exemple d'utilisation Azure + Terraform

Parce que jui pas ~~trop~~ un animal, j'vous file un bon pattern de fichiers Terraform qui fait le job.

**Créez un dossier dédié** et déposez ces 3 fichiers :

### A. Création de fichiers

[Liste des fichiers](../terraform/)

### B. Commandes Terraform

**Une fois les 3 fichiers en place** (`main.tf`, `variables.tf`, `terraform.tfvars`), déplacez-vous dans le dossier, et utilisez des commandes `terraform` :

```bash
# On se déplace dans le dossier qui contient le main.tf et les autres fichiers
cd terraform/

# Initialisation de Terraform, utile une seule fois
# Ici, Terraform va récupérer le nécessaire pour déployer sur Azure spécifiquement
terraform init

# Si vous voulez voir ce qui serait fait avant de déployer, vous pouvez :
terraform plan

# Pour déployer votre "plan Terraform" (ce qui est défini dans le main.tf)
terraform apply

# Pour détruire tout ce qui a été déployé (recommandé de le faire régulièrement pour déployer depuis zéro)
terraform destroy
```

[TP2](../2/part1.md)