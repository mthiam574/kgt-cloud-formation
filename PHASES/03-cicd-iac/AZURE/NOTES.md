# Azure — Phase 03 CI/CD & IaC

## Partie 1 — Terraform

### Fichiers
| Fichier           | Rôle                                |
|-------------------|-------------------------------------|
| main.tf           | Ressources à créer                  |
| variables.tf      | Paramètres configurables            |
| outputs.tf        | Valeurs affichées après apply       |
| terraform.tfstate | Mémoire de l état (ne pas commiter) |

### Ressources créées
| Ressource               | Nom        | Détail               |
|-------------------------|------------|----------------------|
| azurerm_container_group | kgt-app-tf | Conteneur ACI Linux  |

### Data Sources utilisées
| Data Source                | Rôle                           |
|----------------------------|--------------------------------|
| azurerm_resource_group     | Lit le RG existant             |
| azurerm_container_registry | Récupère les credentials ACR   |

### Auth Terraform Azure
az login suffit - pas d etape supplementaire necessaire

### Commandes
terraform init / plan / apply --auto-approve / destroy --auto-approve

## Partie 2 — GitHub Actions CI/CD

### Pipeline à créer (prochaine étape)
.github/workflows/deploy-azure.yml

### Secrets GitHub requis
| Secret                  | Valeur                              |
|-------------------------|-------------------------------------|
| AZURE_CREDENTIALS       | JSON du service principal Azure     |
| AZURE_REGISTRY_LOGIN    | kgtformationregistry.azurecr.io     |
| AZURE_REGISTRY_USERNAME | kgtformationregistry                |
| AZURE_REGISTRY_PASSWORD | Mot de passe ACR                    |

## Leçons apprises
- az login suffit pour Terraform Azure
- Les data sources recuperent les credentials ACR automatiquement
- sensitive value masque les mots de passe dans le plan
- Les namespaces doivent etre enregistres avant usage
- Un seul resource group pour tout organiser
