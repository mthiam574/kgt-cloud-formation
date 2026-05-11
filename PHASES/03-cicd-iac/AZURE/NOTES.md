# Azure — Phase 03 IaC Terraform

## Fichiers Terraform

| Fichier           | Rôle                                    |
|-------------------|-----------------------------------------|
| main.tf           | Ressources à créer                      |
| variables.tf      | Paramètres configurables                |
| outputs.tf        | Valeurs affichées après apply           |
| terraform.tfstate | Mémoire de l état (ne pas commiter)     |

## Ressources créées

| Ressource               | Nom        | Détail               |
|-------------------------|------------|----------------------|
| azurerm_container_group | kgt-app-tf | Conteneur ACI Linux  |

## Data Sources utilisées

| Data Source                   | Rôle                              |
|-------------------------------|-----------------------------------|
| azurerm_resource_group        | Lit le RG existant kgt-formation  |
| azurerm_container_registry    | Récupère les credentials ACR      |

## Provider

provider "azurerm" {
  features {}
}

## Auth Terraform Azure
az login suffit - pas d etape supplementaire necessaire

## Commandes clés
terraform init               - Telecharge le provider Azure
terraform plan               - Previsualise les changements
terraform apply --auto-approve  - Cree sans confirmation
terraform destroy --auto-approve - Supprime sans confirmation

## Points importants
- az login suffit pour Terraform Azure
- Les data sources recuperent les credentials ACR automatiquement
- sensitive value masque les mots de passe dans le plan
- Un seul resource group pour tout organiser
- Providers et namespaces doivent etre enregistres avant usage
