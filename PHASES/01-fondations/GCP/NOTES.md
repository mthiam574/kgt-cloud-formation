# GCP — Phase 01 Fondations

## Compte

| Champ          | Valeur                                      |
|----------------|---------------------------------------------|
| Email          | kgttechnologies74@gmail.com                 |
| Project ID     | project-c2ec1119-b53b-4de5-a77              |
| Type           | Free Trial — 257€ crédits / 90 jours        |
| Expiration     | 07 août 2026                                |
| Console        | https://console.cloud.google.com            |

## Authentification

| Champ          | Valeur                                      |
|----------------|---------------------------------------------|
| Type           | OAuth2 (token temporaire)                   |
| Durée token    | 1 heure (renouvellement automatique)        |
| Refresh token  | Longue durée                                |
| Config locale  | ~/.config/gcloud/                           |
| Credentials    | Stockés dans Bitwarden → GCP                |

## CLI

| Champ          | Valeur                                      |
|----------------|---------------------------------------------|
| Commande       | gcloud                                      |
| Version        | 567.0.0                                     |
| Installation   | ~/google-cloud-sdk/                         |
| PATH           | Ajouté dans ~/.bashrc                       |
| Outils inclus  | gcloud, gsutil, bq                          |

## Commandes de vérification

```bash
# Vérifier le compte actif
gcloud auth list

# Vérifier le projet actif
gcloud config list

# Lister les projets
gcloud projects list

# Lister les VM
gcloud compute instances list
```

## Budget et alertes

| Budget         | Seuils            | Email alerte    |
|----------------|-------------------|-----------------|
| 5€ mensuel     | 50%, 90%, 100%    | email principal |

## Services Free Tier principaux

| Service         | Limite                          |
|-----------------|---------------------------------|
| Compute Engine  | 1x e2-micro (us-regions)        |
| Cloud Storage   | 5 Go                            |
| Cloud Run       | 2M requêtes/mois                |
| BigQuery        | 10 Go stockage + 1 To requêtes  |

## Sécurité

- ✓ Authentification OAuth2 (pas de clés statiques)
- ✓ Token renouvelé automatiquement
- ⏳ IAM roles à affiner par projet
