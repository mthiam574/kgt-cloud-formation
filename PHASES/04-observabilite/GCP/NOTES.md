# GCP — Phase 04 Observabilité

## Services utilisés

| Service              | Rôle                              |
|----------------------|-----------------------------------|
| Cloud Monitoring     | Métriques et alertes              |
| Cloud Logging        | Stockage et analyse des logs      |
| Error Reporting      | Détection automatique des erreurs |
| Cloud Trace          | Traçage des requêtes              |

## Ce qu on a configuré

### Canal de notification
- Type : email
- Adresse : moustaphathiam@hotmail.com
- ID : 7721114046172778150

### Politique d alerte
- Nom : kgt-app-erreurs-5xx
- Métrique : run.googleapis.com/request_count
- Condition : erreurs 5xx > 5 en 60s
- Notification : canal email KGT

## Commandes clés

gcloud services enable monitoring.googleapis.com

gcloud beta monitoring channels create
  --display-name="Email KGT"
  --type=email
  --channel-labels=email_address=EMAIL
  --project PROJECT_ID

gcloud alpha monitoring policies create
  --policy-from-file=alert-policy.json
  --project PROJECT_ID

gcloud monitoring policies list --project PROJECT_ID

## Architecture

Cloud Run (conteneur)
   genere -> Cloud Monitoring Metrics
   declenche -> Alert Policy (5xx > 5)
   envoie -> Notification Channel
   notifie -> Email moustaphathiam@hotmail.com

## Leçons apprises
- Cloud Monitoring collecte automatiquement les métriques Cloud Run
- La CLI GCP alpha/beta est parfois incomplète - fichier JSON plus fiable
- gcloud beta monitoring channels = canaux de notification
- gcloud alpha monitoring policies = politiques d alerte
- Configurer l observabilité AVANT le déploiement en production
