# Comparatif Phase 03 — CI/CD & IaC Terraform

## Providers Terraform

| Cloud | Provider          | Version | Auth requise                          |
|-------|-------------------|---------|---------------------------------------|
| AWS   | hashicorp/aws     | ~> 5.0  | aws configure (clés IAM)              |
| GCP   | hashicorp/google  | ~> 5.0  | gcloud auth application-default login |
| Azure | hashicorp/azurerm | ~> 3.0  | az login                              |

## Complexité Terraform

| Cloud | Ressources | Temps apply | Temps destroy |
|-------|------------|-------------|---------------|
| AWS   | 4          | ~15s        | ~90s          |
| GCP   | 3          | ~20s        | ~20s          |
| Azure | 1          | ~60s        | ~11s          |

## Pipelines GitHub Actions

| Cloud | Fichier              | Statut    | Durée  |
|-------|----------------------|-----------|--------|
| AWS   | deploy-aws.yml       | ✓ opérationnel | 28s |
| GCP   | deploy-gcp.yml       | ⏳ à faire | -     |
| Azure | deploy-azure.yml     | ✓ opérationnel | 1m48s |

## Authentification GitHub Actions

| Cloud | Méthode              | Secret GitHub        |
|-------|----------------------|----------------------|
| AWS   | Clés IAM statiques   | AWS_ACCESS_KEY_ID + AWS_SECRET_ACCESS_KEY |
| GCP   | Workload Identity    | ⏳ à configurer      |
| Azure | Service Principal    | AZURE_CREDENTIALS (JSON) |

## Étapes CI/CD

| Étape          | AWS                    | Azure                  |
|----------------|------------------------|------------------------|
| Auth cloud     | configure-aws-credentials | azure/login         |
| Auth registry  | amazon-ecr-login       | az acr login           |
| Build image    | docker build           | docker build           |
| Push image     | docker push ECR        | docker push ACR        |
| Deploy         | aws ecs update-service | az container create    |
| Durée totale   | 28s                    | 1m48s                  |

## Tags des images

| Méthode    | Format                | Avantage                        |
|------------|-----------------------|---------------------------------|
| Manuel     | v1.0, v2.0            | Lisible                         |
| GitHub SHA | fc8c146...            | Unique, traçable au commit Git  |

## Cycle Terraform

| Commande              | Rôle                              |
|-----------------------|-----------------------------------|
| terraform init        | Télécharge les plugins            |
| terraform plan        | Prévisualise sans toucher         |
| terraform apply       | Crée ou modifie l infrastructure  |
| terraform destroy     | Supprime tout                     |

## Leçons apprises

- CI = build + push image sur le registre
- CD = déploiement automatique sur le service cloud
- La frontière CI/CD = quand l image est prête sur le registre
- github.sha donne un tag unique et traçable par commit
- AWS CI/CD plus rapide que Azure car ECS update-service vs az container create
- Ne jamais commiter terraform.tfstate dans Git
- Les secrets GitHub Actions remplacent les credentials en clair
