# Comparatif Phase 01 — Fondations

## Environnement local — Debian

| Outil      | Version  | Statut      | Notes          |
|------------|----------|-------------|----------------|
| Docker     | 29.4.1   | ✓ installé  | pré-existant   |
| Terraform  | 1.14.9   | ✓ installé  | pré-existant   |
| AWS CLI    | 2.34.45  | ✓ installé  | 08/05/2026     |
| gcloud     | 567.0.0  | ✓ installé  | 08/05/2026     |
| Azure CLI  | 2.86.0   | ✓ installé  | 08/05/2026     |
| kubectl    | -        | ⏳ phase 2   | conteneurs     |

## Comptes Cloud

| Cloud | Statut  | Gratuit         | Notes                     |
|-------|---------|-----------------|---------------------------|
| AWS   | ✓ actif | ✓ Free Tier     | 12 mois                   |
| GCP   | ✓ actif | ✓ 257€ crédits  | 90 jours - expire 07/08   |
| Azure | ✓ actif | ✗ Pay-as-you-go | Azure subscription 1      |

## Alertes Budget

| Cloud | Budget        | Seuils       | Statut  |
|-------|---------------|--------------|---------|
| AWS   | Zero-Spend    | 0.01$        | ✓ actif |
| AWS   | 5$ mensuel    | 5$           | ✓ actif |
| GCP   | 5€ mensuel    | 50% 90% 100% | ✓ actif |
| Azure | 5€ mensuel    | 90%          | ✓ actif |

## Credentials CLI

| Cloud | Utilisateur                    | Région      | Statut       |
|-------|--------------------------------|-------------|--------------|
| AWS   | formation-cli                  | eu-west-3   | ✓ configuré  |
| GCP   | kgttechnologies74@gmail.com    | europe-west9| ✓ configuré  |
| Azure | kgttechnologies74@gmail.com    | francecentral| ✓ configuré |

## Équivalences de services

| Concept        | AWS           | GCP             | Azure            |
|----------------|---------------|-----------------|------------------|
| VM             | EC2           | Compute Engine  | Virtual Machine  |
| Stockage objet | S3            | Cloud Storage   | Blob Storage     |
| IAM            | IAM           | Cloud IAM       | Azure AD / RBAC  |
| CLI            | aws           | gcloud          | az               |
| Région Paris   | eu-west-3     | europe-west9    | francecentral    |
| Config locale  | ~/.aws/       | ~/.config/gcloud| ~/.azure/        |
