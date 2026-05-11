#!/bin/bash

# AWS NOTES
cat > ~/FORMATIONS/CLOUD/PHASES/02-conteneurs/AWS/NOTES.md << 'EOF'
# AWS — Phase 02 Conteneurs

## Service utilisé : ECS Fargate
ECS est le service d'orchestration de conteneurs AWS.
Fargate = mode serverless, pas de serveur à gérer.

## Ressources créées
| Ressource       | Nom               | Détail                          |
|-----------------|-------------------|---------------------------------|
| Registre ECR    | kgt-app           | eu-west-3                       |
| Rôle IAM        | ecsTaskExecutionRole | Accès ECR pour Fargate       |
| Cluster ECS     | kgt-formation     | Vide (desired-count=0)          |
| Task Definition | kgt-app:2         | 0.25 vCPU / 512Mo / port 8080   |
| Security Group  | kgt-app-sg        | Port 8080 ouvert                |
| Service ECS     | kgt-app-service   | Arrêté                          |

## Commandes clés
# Démarrer le conteneur
aws ecs update-service --cluster kgt-formation --service kgt-app-service --desired-count 1 --region eu-west-3

# Arrêter le conteneur
aws ecs update-service --cluster kgt-formation --service kgt-app-service --desired-count 0 --region eu-west-3

## Complexité : 5 étapes — ECR + IAM + Cluster + Task Definition + Security Group + Service
EOF

# GCP NOTES
cat > ~/FORMATIONS/CLOUD/PHASES/02-conteneurs/GCP/NOTES.md << 'EOF'
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
EOF

# AZURE NOTES
cat > ~/FORMATIONS/CLOUD/PHASES/02-conteneurs/AZURE/NOTES.md << 'EOF'
# Azure — Phase 02 Conteneurs

## Service utilisé : ACI (Azure Container Instances)
Simple mais sans HTTPS automatique. Facturation à la seconde.

## Ressources créées
| Ressource      | Nom                  | Détail          |
|----------------|----------------------|-----------------|
| Resource Group | kgt-formation        | francecentral   |
| ACR            | kgtformationregistry | azurecr.io      |
| ACI            | kgt-app              | Supprimé après  |

## Commandes clés
# Déployer
az container create --resource-group kgt-formation --name kgt-app \
  --image kgtformationregistry.azurecr.io/kgt-app:v1.0 \
  --cpu 1 --memory 1 --os-type Linux \
  --ports 8080 --ip-address public

# Supprimer
az container delete --resource-group kgt-formation --name kgt-app --yes

## Complexité : 2 étapes — ACR + ACI
EOF

# COMPARATIF
cat > ~/FORMATIONS/CLOUD/PHASES/02-conteneurs/COMPARATIF.md << 'EOF'
# Comparatif Phase 02 — Conteneurs

## Registres Docker
| Concept     | AWS | GCP                | Azure |
|-------------|-----|--------------------|-------|
| Service     | ECR | Artifact Registry  | ACR   |
| Activation  | Non | gcloud services enable | az provider register |
| Auth Docker | Token 12h | credential helper | credential helper |

## Déploiement conteneurs
| Concept      | AWS ECS Fargate | GCP Cloud Run  | Azure ACI      |
|--------------|-----------------|----------------|----------------|
| Complexité   | 5 étapes        | 1 commande     | 2 étapes       |
| HTTPS auto   | Non             | Oui            | Non            |
| Billing      | À la seconde    | À la requête   | À la seconde   |
| Réseau       | Manuel          | Automatique    | Automatique    |
EOF

echo "Documentation Phase 02 générée ✓"
ls ~/FORMATIONS/CLOUD/PHASES/02-conteneurs/*/NOTES.md
