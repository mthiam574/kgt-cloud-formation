# Comparatif Phase 04 — Observabilité

## Les 3 piliers de l observabilité

| Pilier    | Description                    | AWS              | GCP                | Azure              |
|-----------|--------------------------------|------------------|--------------------|--------------------|
| Logs      | Que s est-il passé ?           | CloudWatch Logs  | Cloud Logging      | Azure Monitor Logs |
| Métriques | Combien ? CPU, RAM, requêtes   | CloudWatch Metrics | Cloud Monitoring | Azure Metrics      |
| Traces    | Où ca bloque ?                 | X-Ray            | Cloud Trace        | Application Insights |

## Services d alerte

| Cloud | Service        | Notification | Coût              |
|-------|----------------|--------------|-------------------|
| AWS   | CloudWatch Alarm + SNS | Email, SMS, Lambda | Gratuit jusqu a 10 alarmes |
| GCP   | Cloud Monitoring Alert | Email, PagerDuty | Gratuit          |
| Azure | Azure Monitor Alert | Email, SMS, Webhook | Gratuit jusqu a 1000 alertes |

## Ce qu on a configuré

| Cloud | Alerte                  | Seuil            | Notification      |
|-------|-------------------------|------------------|-------------------|
| AWS   | kgt-app-cpu-high        | CPU ECS > 80%    | SNS email         |
| GCP   | kgt-app-erreurs-5xx     | 5xx > 5 en 60s   | Canal email       |
| Azure | kgt-acr-storage-alert   | Stockage > 1Go   | Azure Monitor     |

## Comparaison des CLIs

| Cloud | Facilité CLI | Notes                                    |
|-------|-------------|------------------------------------------|
| AWS   | Facile      | CLI mature, tout faisable en ligne de commande |
| GCP   | Difficile   | CLI alpha/beta incomplète, JSON plus fiable |
| Azure | Moyenne     | Bien documentée mais paramètres stricts  |

## Bonne pratique DevOps

L ordre correct en production :
1. Infra (Terraform)
2. Observabilité (logs + métriques + alertes)
3. CI/CD (pipeline)
4. Déploiement

On a fait dans l ordre inverse pour des raisons pédagogiques.

## Leçons apprises
- Configurer l observabilité AVANT le déploiement en production
- Les 3 clouds ont des services équivalents mais des APIs très différentes
- AWS SNS est le plus flexible pour les notifications
- GCP Cloud Monitoring collecte automatiquement les métriques Cloud Run
- Azure Monitor est intégré nativement à tous les services Azure
- La rétention des logs doit être configurée pour éviter des coûts
