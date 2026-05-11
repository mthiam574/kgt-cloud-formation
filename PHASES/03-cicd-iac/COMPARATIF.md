# Comparatif Phase 03 — IaC Terraform

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

## Cycle Terraform

| Commande              | Rôle                              |
|-----------------------|-----------------------------------|
| terraform init        | Télécharge les plugins            |
| terraform plan        | Prévisualise sans toucher         |
| terraform apply       | Crée ou modifie l infrastructure  |
| terraform destroy     | Supprime tout                     |
| --auto-approve        | Évite de taper yes                |

## Data Sources vs Resources

| Type     | Rôle                          | Exemple               |
|----------|-------------------------------|-----------------------|
| resource | Crée une nouvelle ressource   | aws_ecs_cluster       |
| data     | Lit une ressource existante   | data.aws_vpc.default  |

## Fichier tfstate

| Aspect      | Détail                                       |
|-------------|----------------------------------------------|
| Rôle        | Mémoire de l état de l infrastructure        |
| Local       | terraform.tfstate dans le dossier de travail |
| Production  | Stocké dans S3 / GCS / Azure Blob            |
| Git         | Ne jamais commiter ce fichier                |

## Leçons apprises

- Terraform utilise le meme cycle sur les 3 clouds
- Seuls les providers et les noms de ressources changent
- terraform destroy supprime dans le bon ordre automatiquement
- Le suffixe -tf distingue les ressources Terraform des ressources manuelles
- Les data sources evitent les conflits avec les ressources existantes
- GCP necessite une auth supplementaire pour Terraform
- Azure est le plus simple cote auth - az login suffit
