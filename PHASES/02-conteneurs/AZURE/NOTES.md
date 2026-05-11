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
