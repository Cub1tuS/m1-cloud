*[Logs Analytics Workspace]: Une ressource Azure dédié à la centralisation de métriques et de logs, à des fins de visualisation, traitements, et alertes. On peut imaginer que toute une infra, beaucoup de VMs et d'autres ressources Azure, envoie ses logs à votre Logs Analytics Workspace. Ainsi, un seul endroit centralisé pour tout voir, et gérer des alertes par exemple, ou faire de la corrélation d'évènements.
*[Platform Metrics]: Le monitoring natif de Azure, associé à chaque VM. Suffit pour un monitoring élémentaire par VM. Pas de vue globale contrairement à l'utilisation d'un Logs Analytics Workspace.
*[WebUI Azure]: Aussi appelé le "Portal". Là quoi : https://portal.azure.com

# IV. Monitoring

## 1. Introw

➜ **Alors le monitoring avec Azure.**.. euh c'est le bordel ! Ca a beaucoup évolué et le modèle est assez complexe.

On va aller sur quelque chose de simpliste : **monitoring CPU et RAM** déjà, avec des alertes par mail si ça dépasse un certain seuil.

Azure fournit toutes ces features, et on peut tout déployer avec Terraform, let's go :)

Vous pouvez utiliser un *[Logs Analytics Workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview)*, ou rester simple avec l'onglet Monitoring de la VM et les *[Platform Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/metrics/data-platform-metrics)*. Je vous laisse faire vos recherches !

???+ note

    L'idée c'est que les *Platform Metrics* c'est un peu limité, et ça s'intègre mal à autre chose.  
    Mais c'est suffisant pour ce que je vous demande ici.  
    A l'inverse, le Logs *Analytics Workspace* répond à toutes les limites des Platform Metrics.  
    Mais plus complexe à setup.

![Monitoring Azure](../../assets/img/meme_azure_monitoring.png)

## 2. Une alerte CPU

🌞 **Compléter votre plan Terraform et mettez en place une alerte CPU**

- je vous recommande de créer un nouveau fichier `monitoring.tf` à côté de votre `main.tf`
- si le % d'utilisation CPU monte au dessus de 70% une alerte doit être levée
- vous devez recevoir un mail

📁 **Fichiers attendus**

- `main.tf`
- `monitoring.tf` (je vous file un exemple en dessous)
- tout autre fichier Terraform utilisé

---

## Help : Exemple de fichier Terraform

➜ **OKOK voilà le code j'ai compris...**

???+ example

    Ca c'est la version simple avec les *Platform Metrics* donc !

    ```tf
    # monitoring.tf
    
    resource "azurerm_monitor_action_group" "main" {
      name                = "ag-${var.resource_group_name}-alerts"
      resource_group_name = azurerm_resource_group.main.name
      short_name          = "vm-alerts"
    
      email_receiver {
        name          = "admin"
        email_address = var.alert_email_address
      }
    }
    
    # CPU Metric Alert (using platform metrics)
    resource "azurerm_monitor_metric_alert" "cpu_alert" {
      name                = "cpu-alert-${azurerm_linux_virtual_machine.main.name}"
      resource_group_name = azurerm_resource_group.main.name
      scopes              = [azurerm_linux_virtual_machine.main.id]
      description         = "Alert when CPU usage exceeds 70%"
      severity            = 2
    
      criteria {
        metric_namespace = "Microsoft.Compute/virtualMachines"
        metric_name      = "Percentage CPU"
        aggregation      = "Average"
        operator         = "GreaterThan"
        threshold        = 70
      }
    
      window_size   = "PT5M"
      frequency     = "PT1M"
      auto_mitigate = true
    
      action {
        action_group_id = azurerm_monitor_action_group.main.id
      }
    }
    ```


➜ Une fois que t'as déployé ça, tu peux voir dans la WebUI Azure :

- **un graphe de la métrique CPU récoltée :**

    - dans `Virtual Machines` > `TA_VM` > `Monitoring` > `Metrics` > Sélectionne `Percentage CPU`
    - ici, on voit les *Platform Metrics* donc

- **la liste des alertes qui ont été *fired*** 

    - "*fired*" ou "*triggered*" ou "déclenchées"
    - dans `Virtual Machines` > `TA_VM` > `Monitoring` > `Alerts`
    - ui c'est vide pour le moment

- **une alerte prête à *fire* (être déclenchée) si un seuil est dépassé**

    - dans `Virtual Machines` > `TA_VM` > `Monitoring` > `Alerts` > `Alert Rules`

???+ note

    Avec un *Logs Analytics Workspace*, vous auriez eu des boutons similaires disponibles dans le Workspace créé (il porte un nom de votre choix).

## 3. Alerte mémoire

🌞 **Compléter votre plan Terraform et mettez en place une alerte mémoire**

- la "mémoire" ou "memory", c'est la RAM hein, pas le stockage (je précise au cas où, te sens pas insulté)
- s'il y a moins de 512M de RAM dispo, une alerte doit être levée
- vous devez recevoir un mail

📁 **Fichiers attendus**

- `main.tf`
- `monitoring.tf`
- tout autre fichier Terraform utilisé

## 4. Proofs

### A. Voir les alertes avec `az`

🌞 **Une commande `az` qui permet de lister les alertes actuellement configurées**

- on doit voir l'alerte RAM
- on doit voir l'alerte CPU

### B. Stress pour *fire* les alertes

🌞 **Stress de la machine**

- installez le paquet `stress-ng` dans la VM
- utilisez la commande `stress-ng` pour :

    - stress le CPU (donner la commande)
    - stress la RAM (donner la commande)

???+ tip

    **Soyez patients** avant que l'alerte remonte. Il est pas pressé Azure parfois. 
    Aussi, **assurez-vous avec les graphes de monitoring** que vous dépassez bien les seuils.  
    Ca prend **5 minutes ou +** pour que l'alerte tombe. Je lance mes stress sur 10 minutes pour les tests.

🌞 **Vérifier que des alertes ont été *fired***

- normalement t'as un mail
- tu le vois dans la WebUI Azure
- **dans le compte-rendu**, je veux une commande `az` qui montre que les alertes ont été levées

???+ tip

    Ca va être avec du `az monitor activity-log list` probablement :)
