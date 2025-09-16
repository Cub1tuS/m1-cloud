# IV. Monitoring

## 1. Introw

➜ **Alors le monitoring avec Azure.**.. euh c'est le bordel ! Ca a beaucoup évolué et le modèle est assez complexe.

On va aller sur quelque chose de simpliste : **monitoring CPU et RAM** déjà, avec des alertes par mail si ça dépasse un certain seuil.

Azure fournit toutes ces features, et on peut tout déployer avec Terraform, let's go :)

## 2. Une alerte CPU

🌞 **Compléter votre plan Terraform et mettez en place une alerte CPU**

[Fichier Monitoring](../terraform/monitoring.tf)

## 3. Alerte mémoire

🌞 **Compléter votre plan Terraform et mettez en place une alerte mémoire**

[Fichier Monitoring](../terraform/monitoring.tf)

## 4. Proofs

### A. Voir les alertes avec `az`

🌞 **Une commande `az` qui permet de lister les alertes actuellement configurées**

```
dorian@Air-de-Dorian terraform % az monitor metrics alert list --resource-group tf-cloud-tp1 --output table
AutoMitigate    Description                           Enabled    EvaluationFrequency    Location    Name                   ResourceGroup    Severity    TargetResourceRegion    TargetResourceType    WindowSize
--------------  ------------------------------------  ---------  ---------------------  ----------  ---------------------  ---------------  ----------  ----------------------  --------------------  ------------
True            Alert when CPU usage exceeds 70%      True       PT1M                   global      cpu-alert-super-vm     tf-cloud-tp1     2                                                         PT5M
True            Alert when available memory < 512 MB  True       PT1M                   global      memory-alert-super-vm  tf-cloud-tp1     2                                                         PT5M
```

### B. Stress pour *fire* les alertes

🌞 **Stress de la machine**

```
stress-ng --cpu 1 --timeout 600s
```

```
stress-ng --vm 2 --vm-bytes 90% --timeout 600s
```

🌞 **Vérifier que des alertes ont été *fired***

```
dorian@Air-de-Dorian terraform % az monitor activity-log list \
  --resource-group tf-cloud-tp1 \
  --status Failed \
  --output table
```
