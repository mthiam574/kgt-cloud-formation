---
layout: default
title: Phase 04 Observabilite
nav_order: 5
---

# Phase 04 — Observabilité et supervision

L'observabilité est la capacité à comprendre l'état interne d'un système
à partir de ses données externes. Elle repose sur trois piliers :
les **métriques** (mesures chiffrées), les **logs** (traces d'événements),
et les **alertes** (notifications automatiques en cas d'anomalie).

---

## Bilan de la phase

| Pilier | AWS | GCP | Azure |
|---|---|---|---|
| **Service de supervision** | CloudWatch | Cloud Monitoring | Azure Monitor |
| **Service de logs** | CloudWatch Logs | Cloud Logging | Log Analytics Workspace |
| **Dashboards** | ✅ Configuré | ✅ Configuré | ✅ Configuré |
| **Alertes** | ✅ Via SNS | ✅ Via email | ✅ Via groupes d'action |

---

## AWS — CloudWatch

**CloudWatch** est le service de supervision d'AWS. Il collecte métriques
et logs de tous les services AWS (ECS, ECR, Lambda, EC2...) et permet
de créer des alarmes qui déclenchent des notifications.

**SNS — Simple Notification Service** est le service de messagerie AWS
utilisé pour envoyer les notifications d'alerte par email.

Consulter les métriques d'un service ECS :

    aws cloudwatch get-metric-statistics \
      --namespace AWS/ECS \
      --metric-name CPUUtilization \
      --dimensions Name=ClusterName,Value=kgt-cluster \
      --start-time 2026-01-01T00:00:00Z \
      --end-time 2026-01-02T00:00:00Z \
      --period 3600 \
      --statistics Average \
      --region eu-west-3

Lister les alarmes configurées :

    aws cloudwatch describe-alarms --region eu-west-3

Lister les groupes de logs :

    aws logs describe-log-groups --region eu-west-3

Lire les logs d'un groupe :

    aws logs get-log-events \
      --log-group-name /ecs/kgt-app \
      --log-stream-name <stream-name> \
      --region eu-west-3

Les logs CloudWatch sont configurés avec une rétention de 30 jours pour
maîtriser les coûts — la rétention infinie est facturée à l'ingestion.

---

## GCP — Cloud Monitoring et Cloud Logging

**Cloud Monitoring** est le service de supervision GCP. Il collecte les
métriques de tous les services GCP et permet de créer des dashboards
et des alertes. **Cloud Logging** centralise tous les logs — sur Cloud Run,
les logs arrivent automatiquement sans configuration supplémentaire.

Consulter les logs Cloud Run :

    gcloud logging read \
      "resource.type=cloud_run_revision AND resource.labels.service_name=kgt-app" \
      --limit 50 \
      --region europe-west9

Lister les métriques disponibles pour Cloud Run :

    gcloud monitoring metrics list \
      --filter="metric.type=run.googleapis.com"

Vérifier l'état d'un service Cloud Run :

    gcloud run services describe kgt-app \
      --region europe-west9 \
      --format="value(status.conditions)"

Les alertes GCP sont configurées dans Cloud Monitoring → Alerting avec
des seuils sur la latence et le taux d'erreurs HTTP 5xx.

---

## Azure — Azure Monitor et Log Analytics

**Azure Monitor** est la plateforme centrale de supervision Azure.
Elle regroupe les métriques, les logs et les alertes. **Log Analytics
Workspace** est l'espace de travail qui centralise tous les logs pour
les analyser avec le langage de requête KQL (Kusto Query Language).

Consulter les logs d'un conteneur ACI :

    az container logs \
      --resource-group kgt-formation \
      --name kgt-app

Lister les alertes configurées :

    az monitor alert list \
      --resource-group kgt-formation \
      --output table

Consulter les métriques d'un registre ACR :

    az monitor metrics list \
      --resource $(az acr show --name kgtformationregistry --query id -o tsv) \
      --metric SuccessfulPullCount \
      --output table

Les alertes Azure utilisent des **groupes d'action** (action groups) qui
définissent qui notifier et comment — email, webhook, SMS. Un groupe d'action
peut être réutilisé par plusieurs règles d'alerte.

---

## Comparatif — Services de supervision

| Critère | CloudWatch (AWS) | Cloud Monitoring (GCP) | Azure Monitor |
|---|---|---|---|
| **Intégration native** | Excellente avec les services AWS | Excellente avec GCP | Excellente avec Azure |
| **Logs applicatifs** | CloudWatch Logs — configuration requise | Cloud Logging — automatique sur Cloud Run | Log Analytics — workspace à créer |
| **Langage de requête logs** | CloudWatch Insights | Logging Query Language | KQL — Kusto Query Language |
| **Coût des logs** | Facturation à l'ingestion — attention | Inclus dans le Free Tier | Facturation au volume ingéré |
| **Complexité de configuration** | Moyenne | Faible — très intégré | Élevée — de nombreux composants |

---

## Ce que j'ai appris

- La supervision doit être mise en place dès le début, pas ajoutée après —
  sans métriques, il est impossible de détecter une anomalie
- Les logs non structurés (texte libre) sont difficiles à analyser —
  le format JSON est préférable car il permet des requêtes précises
- La rétention des logs a un coût réel sur AWS et Azure — définir
  des politiques de rétention dès le départ évite les mauvaises surprises
- Une alerte sans documentation associée (qui appeler, quoi vérifier)
  ne sert à rien en situation réelle
