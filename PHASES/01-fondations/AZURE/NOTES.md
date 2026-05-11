# Azure — Phase 01 Fondations

## Compte

| Champ             | Valeur                                        |
|-------------------|-----------------------------------------------|
| Email             | kgttechnologies74@gmail.com                   |
| Tenant ID         | 447700b7-0c52-4e2c-bb21-d6bc895296c0          |
| Subscription ID   | a8d50b8a-bf03-4c94-9e50-1510888d02e4          |
| Subscription name | Azure subscription 1                          |
| Tenant domain     | kgttechnologies74gmail.onmicrosoft.com        |
| Type              | Pay-as-you-go                                 |
| Console           | https://portal.azure.com                      |

## Authentification

| Champ          | Valeur                                        |
|----------------|-----------------------------------------------|
| Type           | OAuth2 (token temporaire)                     |
| Durée token    | 1 heure (renouvellement automatique)          |
| Refresh token  | 90 jours (redemande az login après 90j sans usage) |
| Config locale  | ~/.azure/                                     |
| Credentials    | Stockés dans Bitwarden → AZURE                |

## CLI

| Champ          | Valeur                                        |
|----------------|-----------------------------------------------|
| Commande       | az                                            |
| Version        | 2.86.0                                        |
| Installation   | /opt/az/ (paquet Debian)                      |
| Python         | /opt/az/bin/python3                           |

## Commandes de vérification

```bash
# Vérifier le compte actif
az account show

# Lister les abonnements
az account list --output table

# Lister les VM
az vm list --output table

# Lister les groupes de ressources
az group list --output table
```

## Budget et alertes

| Budget         | Seuil  | Email alerte    |
|----------------|--------|-----------------|
| 5€ mensuel     | 90%    | email principal |

## Services gratuits principaux

| Service              | Limite                     |
|----------------------|----------------------------|
| Azure VM (B1s)       | 750h/mois (12 mois)        |
| Blob Storage         | 5 Go LRS                   |
| Azure Functions      | 1M exécutions/mois         |
| Azure Kubernetes     | Gestion cluster gratuite   |

## Sécurité

- ✓ Authentification OAuth2 (pas de clés statiques)
- ✓ Token renouvelé automatiquement
- ⏳ RBAC roles à configurer
- ⏳ MFA à activer sur le compte Microsoft
