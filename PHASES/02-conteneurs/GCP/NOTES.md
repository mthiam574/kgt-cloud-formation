# GCP — Phase 02 Conteneurs

## Service utilisé : Cloud Run
Serverless — 1 commande pour déployer. HTTPS automatique. Coût nul sans requêtes.

## Ressources créées
| Ressource         | Nom     | Détail                    |
|-------------------|---------|---------------------------|
| Artifact Registry | kgt-app | europe-west9              |
| Cloud Run         | kgt-app | Supprimé après le lab     |

## Commandes clés
# Déployer
gcloud run deploy kgt-app \
  --image europe-west9-docker.pkg.dev/project-c2ec1119-b53b-4de5-a77/kgt-app/kgt-app:v1.0 \
  --platform managed --region europe-west9 \
  --allow-unauthenticated --port 8080

# Supprimer
gcloud run services delete kgt-app --region europe-west9 --quiet

## Complexité : 1 commande
