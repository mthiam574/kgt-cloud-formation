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
