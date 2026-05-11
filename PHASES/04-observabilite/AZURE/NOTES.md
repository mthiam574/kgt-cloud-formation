# Azure — Phase 04 Observabilité

## Services utilisés

| Service              | Rôle                              |
|----------------------|-----------------------------------|
| Azure Monitor        | Métriques et alertes              |
| Log Analytics        | Stockage et analyse des logs      |
| Application Insights | Monitoring des applications       |
| Azure Alerts         | Alertes sur seuils                |

## Ce qu on a configuré

### Alerte métriques ACR
- Nom : kgt-acr-storage-alert
- Ressource : kgtformationregistry (ACR)
- Métrique : StorageUsed
- Seuil : > 1 Go (1073741824 bytes)
- Fréquence : 1h
- Sévérité : 2 (Warning)

## Commandes clés

az monitor metrics alert create
  --name "kgt-acr-storage-alert"
  --resource-group kgt-formation
  --scopes RESOURCE_ID
  --condition "avg StorageUsed > 1073741824"
  --evaluation-frequency 1h
  --window-size PT1H
  --severity 2

az monitor metrics alert list --resource-group kgt-formation

az monitor metrics alert delete --name kgt-acr-storage-alert --resource-group kgt-formation

## Architecture

ACR (registre)
   genere -> Azure Monitor Metrics
   declenche -> Metric Alert (StorageUsed > 1Go)
   notifie -> Email (si action group configuré)

## Leçons apprises
- Azure Monitor est intégré à tous les services Azure
- window-size doit correspondre aux valeurs supportées par la métrique
- evaluation-frequency = fréquence de vérification
- severity va de 0 (critique) à 4 (verbose)
- Configurer l observabilité AVANT le déploiement en production
