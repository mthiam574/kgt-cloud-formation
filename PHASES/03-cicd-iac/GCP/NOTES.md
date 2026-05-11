# GCP — Phase 03 IaC Terraform

## Fichiers Terraform

| Fichier           | Rôle                                    |
|-------------------|-----------------------------------------|
| main.tf           | Ressources à créer                      |
| variables.tf      | Paramètres configurables                |
| outputs.tf        | Valeurs affichées après apply           |
| terraform.tfstate | Mémoire de l état (ne pas commiter)     |

## Ressources créées

| Ressource                          | Nom        | Détail            |
|------------------------------------|------------|-------------------|
| google_project_service             | run API    | Active Cloud Run  |
| google_cloud_run_v2_service        | kgt-app-tf | Service Cloud Run |
| google_cloud_run_v2_service_iam_member | public | Accès public      |

## Provider

provider "google" {
  project = var.project_id
  region  = var.region
}

## Auth Terraform GCP
gcloud auth application-default login
Différent de gcloud auth login - spécifique aux outils tiers comme Terraform

## Commandes clés
terraform init      - Telecharge le provider Google
terraform plan      - Previsualise les changements
terraform apply     - Cree l infrastructure
terraform destroy --auto-approve - Supprime sans confirmation

## Output
service_url = URL HTTPS generee automatiquement par Cloud Run

## Points importants
- GCP necessite application-default login pour Terraform
- Les APIs doivent etre activees avant de creer les ressources
- disable_on_destroy = false pour ne pas desactiver l API au destroy
- Cloud Run genere une URL HTTPS automatiquement
- Facturation a la requete - cout nul sans trafic
