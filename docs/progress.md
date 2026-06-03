---
layout: default
title: Progression
nav_order: 7
---
# Progression de la formation
## Statut global
Phase 01 — Fondations          : Termine
Phase 02 — Conteneurs          : Termine
Phase 03 — IaC et CI/CD        : Termine (CI/CD GCP en attente)
Phase 04 — Observabilite       : Termine
Phase 05 — Kubernetes (bonus)  : Termine
## Detail par phase
### Phase 01 — Fondations
AWS CLI installe et configure        : OK
GCP CLI installe et configure        : OK
Azure CLI installe et configure      : OK
Alertes budget AWS (5 USD)           : OK
Alertes budget GCP (5 EUR)           : OK
Alertes budget Azure (5 EUR)         : OK
### Phase 02 — Conteneurs
Docker installe sur Debian           : OK
Image buildee et optimisee           : OK
Push ECR (AWS)                       : OK
Push Artifact Registry (GCP)        : OK
Push ACR (Azure)                     : OK
Deploiement ECS Fargate (AWS)        : OK
Deploiement Cloud Run (GCP)          : OK
Deploiement ACI (Azure)              : OK
### Phase 03 — IaC et CI/CD
Terraform AWS                        : OK
Terraform GCP                        : OK
Terraform Azure                      : OK
GitHub Actions AWS                   : OK
GitHub Actions Azure                 : OK
GitHub Actions GCP                   : Bloque (Free Trial)
### Phase 04 — Observabilite
CloudWatch AWS                       : OK
Cloud Monitoring GCP                 : OK
Azure Monitor                        : OK
### Phase 05 — Kubernetes (bonus)
GKE (GCP)                            : OK
EKS (AWS)                            : OK
AKS (Azure)                          : OK
## Point de blocage actuel
CI/CD GCP bloque sur la creation de cles JSON service account (politique Free Trial).
Solution identifiee : Workload Identity Federation. Implementation prevue ultérieurement.
## Ce site
GitHub Pages avec Jekyll Just the Docs, deploye automatiquement via GitHub Actions.
URL : https://mthiam574.github.io/kgt-cloud-formation
