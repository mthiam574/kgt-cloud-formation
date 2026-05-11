# AWS — Phase 01 Fondations

## Compte

| Champ          | Valeur                    |
|----------------|---------------------------|
| Account ID     | 774941661781              |
| Alias          | KGT                       |
| Email          | (nouveau email dédié)     |
| Région défaut  | eu-west-3 (Paris)         |
| Type           | Free Tier (12 mois)       |
| Console        | https://console.aws.amazon.com |

## Utilisateur IAM

| Champ          | Valeur                    |
|----------------|---------------------------|
| Utilisateur    | formation-cli             |
| Politique      | AdministratorAccess       |
| Type de clé    | Clés statiques (Access Key + Secret) |
| Durée de vie   | Indéfinie (rotation recommandée tous les 90j) |
| Credentials    | Stockés dans Bitwarden → AWS |

## CLI

| Champ          | Valeur                    |
|----------------|---------------------------|
| Commande       | aws                       |
| Version        | 2.34.45                   |
| Config locale  | ~/.aws/credentials        |
| Config locale  | ~/.aws/config             |
| Installation   | /usr/local/aws-cli/       |

## Commandes de vérification

```bash
# Vérifier l'identité
aws sts get-caller-identity

# Lister les régions disponibles
aws ec2 describe-regions --output table

# Lister les instances EC2
aws ec2 describe-instances --region eu-west-3
```

## Budget et alertes

| Budget         | Seuil    | Email alerte     |
|----------------|----------|------------------|
| Zero-Spend     | 0.01$    | email principal  |
| Mensuel        | 5$       | email principal  |

## Services Free Tier principaux

| Service | Limite mensuelle          |
|---------|---------------------------|
| EC2     | 750h t2.micro ou t3.micro |
| S3      | 5 Go stockage             |
| RDS     | 750h db.t2.micro          |
| Lambda  | 1M requêtes               |

## Sécurité

- ✓ Pas de clé sur le compte root
- ✓ Utilisateur IAM dédié pour CLI
- ⏳ MFA root à configurer
- ⏳ Rotation des clés à planifier (90j)
