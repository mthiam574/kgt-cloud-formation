---
layout: default
title: Phase 03 IaC et CICD
nav_order: 4
---

# Phase 03 — Infrastructure as Code et CI/CD

IaC (Infrastructure as Code — Infrastructure en tant que Code) signifie décrire
et provisionner l'infrastructure via des fichiers de configuration versionnés,
plutôt que de cliquer dans des consoles web. CI/CD (Continuous Integration /
Continuous Deployment — Intégration Continue / Déploiement Continu) automatise
les tests et les déploiements à chaque modification du code.

---

## Bilan de la phase

| Objectif | AWS | GCP | Azure |
|---|---|---|---|
| **Terraform** | ✅ Déployé | ✅ Déployé | ✅ Déployé |
| **CI/CD GitHub Actions** | ✅ Opérationnel | ⏳ Bloqué Free Trial | ✅ Opérationnel |
| **State Terraform** | Local | Local | Local |

---

## Terraform — Structure du projet

Terraform est un outil IaC qui permet de provisionner des ressources cloud
via des fichiers `.tf`. La même syntaxe s'applique aux trois clouds — seul
le provider change.

Structure du projet Terraform :

    TERRAFORM/
      aws/
        main.tf       ← ressources AWS à créer
        variables.tf  ← variables paramétrables
        outputs.tf    ← valeurs retournées après apply
      gcp/
        main.tf
        variables.tf
        outputs.tf
      azure/
        main.tf
        variables.tf
        outputs.tf

Cycle de vie Terraform — les 4 commandes essentielles :

    terraform init      ← télécharge les providers et initialise le projet
    terraform validate  ← vérifie la syntaxe des fichiers .tf
    terraform plan      ← montre les changements prévus sans les appliquer
    terraform apply     ← applique les changements (crée, modifie, détruit)
    terraform destroy   ← détruit toutes les ressources créées

---

## AWS — Terraform

Le provider Terraform AWS s'authentifie avec les credentials IAM stockés
dans `~/.aws/credentials`.

Contenu de `TERRAFORM/aws/variables.tf` :

    variable "region" {
      description = "Region AWS"
      default     = "eu-west-3"
    }

    variable "app_name" {
      description = "Nom de l'application"
      default     = "kgt-app"
    }

    variable "account_id" {
      description = "AWS Account ID"
      default     = "774941661781"
    }

Déploiement :

    cd ~/FORMATIONS/CLOUD/TERRAFORM/aws
    terraform init
    terraform plan
    terraform apply -auto-approve

Destruction des ressources après les tests :

    terraform destroy -auto-approve

---

## GCP — Terraform

Le provider Terraform GCP s'authentifie via les credentials gcloud
stockés dans `~/.config/gcloud/`.

Contenu de `TERRAFORM/gcp/variables.tf` :

    variable "project_id" {
      description = "ID du projet GCP"
      default     = "project-c2ec1119-b53b-4de5-a77"
    }

    variable "region" {
      description = "Region GCP"
      default     = "europe-west9"
    }

    variable "app_name" {
      description = "Nom de l'application"
      default     = "kgt-app"
    }

Déploiement :

    cd ~/FORMATIONS/CLOUD/TERRAFORM/gcp
    terraform init
    terraform plan
    terraform apply -auto-approve
    terraform destroy -auto-approve

---

## Azure — Terraform

Le provider Terraform Azure (azurerm) s'authentifie via le token az CLI
stocké dans `~/.azure/`.

Contenu de `TERRAFORM/azure/variables.tf` :

    variable "location" {
      description = "Region Azure"
      default     = "francecentral"
    }

    variable "resource_group" {
      description = "Resource Group"
      default     = "kgt-formation"
    }

    variable "app_name" {
      description = "Nom de l'application"
      default     = "kgt-app"
    }

    variable "registry_name" {
      description = "Nom du registre ACR"
      default     = "kgtformationregistry"
    }

Déploiement :

    cd ~/FORMATIONS/CLOUD/TERRAFORM/azure
    terraform init
    terraform plan
    terraform apply -auto-approve
    terraform destroy -auto-approve

---

## CI/CD — GitHub Actions

GitHub Actions est le système d'automatisation intégré à GitHub. Un workflow
est un fichier YAML placé dans `.github/workflows/` qui définit les actions
à exécuter automatiquement sur chaque `git push`.

Les workflows sont dans `.github/workflows/` à la racine du dépôt :

    .github/workflows/
      deploy-aws.yml    ← déploiement automatique sur AWS
      deploy-azure.yml  ← déploiement automatique sur Azure
      pages.yml         ← déploiement de ce site GitHub Pages

### AWS — deploy-aws.yml

Le workflow AWS s'authentifie avec les credentials IAM stockés dans les
GitHub Secrets du dépôt (Settings → Secrets and variables → Actions) :

- `AWS_ACCESS_KEY_ID` — identifiant de la clé IAM
- `AWS_SECRET_ACCESS_KEY` — clé secrète IAM

Le workflow se déclenche sur chaque push sur la branche `main`, configure
les credentials AWS, puis exécute les commandes Terraform ou Docker.

### Azure — deploy-azure.yml

Le workflow Azure utilise le Service Principal `github-actions-kgt`
(créé dans Microsoft Entra ID) avec ces secrets GitHub :

- `AZURE_CLIENT_ID` — identifiant du Service Principal
- `AZURE_CLIENT_SECRET` — secret du Service Principal
- `AZURE_TENANT_ID` — identifiant du tenant Microsoft Entra
- `AZURE_SUBSCRIPTION_ID` — identifiant de la subscription Azure

### GCP — Bloqué

La politique Free Trial GCP interdit la création de clés JSON pour les
comptes de service — clés nécessaires pour que GitHub Actions s'authentifie
sur GCP. Solution identifiée : Workload Identity Federation (WIF), qui
permet à GitHub Actions de s'authentifier sur GCP via un mécanisme de
confiance mutuelle sans clé JSON. Implémentation prévue en phase 05.

---

## Comparatif — Authentification CI/CD

| Critère | AWS | GCP | Azure |
|---|---|---|---|
| **Mécanisme** | Clés IAM statiques dans GitHub Secrets | WIF — Workload Identity Federation (prévu) | Service Principal `github-actions-kgt` |
| **Type de credentials** | Access Key + Secret Key | Token temporaire via OIDC | Client ID + Secret |
| **Risque** | Moyen — clés statiques à rotation régulière | Faible — pas de clé stockée | Moyen — secret à renouveler |
| **Statut** | ✅ Opérationnel | ⏳ En cours | ✅ Opérationnel |

---

## Ce que j'ai appris

- Terraform `plan` avant chaque `apply` est indispensable — il montre
  exactement ce qui va être créé, modifié ou détruit
- Les credentials ne doivent jamais être dans les fichiers `.tf` —
  GitHub Secrets est la bonne approche pour le CI/CD
- Le Workload Identity Federation de GCP est plus sécurisé que les clés
  statiques AWS : pas de secret à stocker, pas de risque de fuite
- Un workflow GitHub Actions qui échoue est visible immédiatement dans
  l'onglet Actions — le debugging se fait sur les logs du runner
