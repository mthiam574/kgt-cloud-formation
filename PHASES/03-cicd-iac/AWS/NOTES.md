# AWS — Phase 03 IaC Terraform

## Fichiers Terraform

| Fichier           | Rôle                                    |
|-------------------|-----------------------------------------|
| main.tf           | Ressources à créer                      |
| variables.tf      | Paramètres configurables                |
| outputs.tf        | Valeurs affichées après apply           |
| terraform.tfstate | Mémoire de l état (ne pas commiter)     |

## Ressources créées

| Ressource       | Nom                | Détail            |
|-----------------|--------------------|-------------------|
| Security Group  | kgt-app-sg-tf      | Port 8080 ouvert  |
| Cluster ECS     | kgt-formation-tf   | Cluster Fargate   |
| Task Definition | kgt-app-tf         | 0.25 vCPU / 512Mo |
| Service ECS     | kgt-app-service-tf | desired-count=1   |

## Provider

provider "aws" {
  region = var.aws_region
}

## Auth Terraform
aws configure avec les clés IAM de formation-cli

## Commandes clés
terraform init      - Telecharge le provider AWS
terraform plan      - Previsualise les changements
terraform apply     - Cree l infrastructure
terraform destroy   - Supprime tout

## Points importants
- tfstate ne jamais commiter dans Git
- En production tfstate stocke dans S3 (backend remote)
- Suffixe -tf pour distinguer des ressources manuelles
- Les data sources lisent les ressources existantes sans les recreer
- Les tags identifient les ressources creees par Terraform
