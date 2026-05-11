# GCP — Phase 03 CI/CD & IaC

## Partie 1 — Terraform

### Fichiers
| Fichier           | Rôle                                |
|-------------------|-------------------------------------|
| main.tf           | Ressources à créer                  |
| variables.tf      | Paramètres configurables            |
| outputs.tf        | Valeurs affichées après apply       |
| terraform.tfstate | Mémoire de l état (ne pas commiter) |

### Ressources créées
| Ressource                          | Nom        | Détail            |
|------------------------------------|------------|-------------------|
| google_project_service             | run API    | Active Cloud Run  |
| google_cloud_run_v2_service        | kgt-app-tf | Service Cloud Run |
| google_cloud_run_v2_service_iam_member | public | Accès public      |

### Auth Terraform GCP
gcloud auth application-default login
Différent de gcloud auth login - spécifique aux outils tiers

### Commandes
terraform init / plan / apply / destroy --auto-approve

### Output
service_url = URL HTTPS générée automatiquement par Cloud Run

## Partie 2 — GitHub Actions CI/CD

### Pipeline à créer (prochaine étape)
.github/workflows/deploy-gcp.yml

### Secrets GitHub requis
| Secret           | Valeur                              |
|------------------|-------------------------------------|
| GCP_PROJECT_ID   | project-c2ec1119-b53b-4de5-a77      |
| GCP_SA_KEY       | Clé JSON du compte de service GCP   |
| GCP_REGION       | europe-west9                        |

## Leçons apprises
- GCP necessite application-default login pour Terraform
- Cloud Run genere une URL HTTPS automatiquement
- Facturation a la requete - cout nul sans trafic
- Les APIs doivent etre activees avant de creer les ressources
