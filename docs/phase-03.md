---
layout: default
title: Phase 03 IaC et CICD
nav_order: 4
---

# Phase 03 — Infrastructure as Code et CI/CD

Terraform pour provisionner l'infrastructure sur les 3 clouds, GitHub Actions
pour automatiser les déploiements sur AWS et Azure.

## Terraform — structure du projet

Un répertoire par cloud, modules réutilisables, state stocké en remote
(S3 pour AWS, GCS pour GCP, Azure Storage pour Azure).

Structure type par cloud :

    terraform/
      aws/
        main.tf
        variables.tf
        outputs.tf
        backend.tf
      gcp/
        main.tf
        variables.tf
      azure/
        main.tf
        variables.tf

Commandes de base : `terraform init`, `terraform plan`, `terraform apply -auto-approve`,
`terraform destroy`.

## AWS — GitHub Actions CI/CD

Workflow déclenché sur push vers main. Les credentials AWS sont stockés dans les
GitHub Secrets (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY). Le workflow fait :
checkout, configure-aws-credentials, terraform init, terraform plan, terraform apply.

## Azure — GitHub Actions CI/CD

Même logique avec les secrets Azure (AZURE_CLIENT_ID, AZURE_CLIENT_SECRET,
AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID) via le provider azurerm.

## GCP — Bloqué (en cours)

La politique Free Trial GCP empêche la création de clés JSON pour les comptes
de service. La solution identifiée est Workload Identity Federation — il lie
GitHub Actions directement à GCP sans clé JSON. Non encore implémenté.

## Ce que j'ai appris

- La valeur de l'IaC : recréer toute une infrastructure en une commande
- Toujours versionner les fichiers Terraform, jamais le state
- Les secrets ne doivent jamais apparaître dans le code — GitHub Secrets est la bonne approche
- `terraform plan` avant chaque apply est non négociable en prod
