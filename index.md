---
layout: home
title: Accueil
nav_order: 1
---

# Formation DevOps Cloud — Moustapha THIAM
{: .fs-9 }

Administrateur système Linux en formation DevOps Cloud. Ce site documente une formation
pratique construite de zéro sur trois fournisseurs cloud en parallèle : Amazon Web Services
(AWS), Google Cloud Platform (GCP) et Microsoft Azure.
{: .fs-5 .fw-300 }

[Voir la progression →](docs/progress.md)
[GitHub ↗](https://github.com/mthiam574/kgt-cloud-formation){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## Services pratiqués par catégorie

| Catégorie | AWS | GCP | Azure |
|---|---|---|---|
| **Registre de conteneurs** | ECR — Elastic Container Registry | Artifact Registry | ACR — Azure Container Registry |
| **Exécution de conteneurs** | ECS Fargate — Elastic Container Service | Cloud Run | ACI — Azure Container Instances |
| **Infrastructure as Code** | Terraform | Terraform | Terraform |
| **CI/CD** — Intégration et déploiement continus | GitHub Actions | GitHub Actions ⏳ | GitHub Actions |
| **Supervision** | CloudWatch | Cloud Monitoring | Azure Monitor |

---

## Phases de la formation

| Phase | Thème | Contenu | Statut |
|---|---|---|---|
| [01 — Fondations](docs/phase-01.md) | Mise en place | CLI (Command Line Interface) · IAM (Identity and Access Management) · Alertes budget | ✅ Terminé |
| [02 — Conteneurs](docs/phase-02.md) | Containerisation | Docker · Registres d'images · Services d'exécution managés | ✅ Terminé |
| [03 — IaC et CI/CD](docs/phase-03.md) | Automatisation | Terraform · GitHub Actions · Déploiement automatisé | ✅ Terminé |
| [04 — Observabilité](docs/phase-04.md) | Supervision | Métriques · Logs · Alertes · Dashboards | ✅ Terminé |
| [05 — Kubernetes](docs/phase-04.md) | Orchestration | EKS (Elastic Kubernetes Service) · GKE (Google Kubernetes Engine) · AKS (Azure Kubernetes Service) | ⏳ En cours |

---

## Environnement de travail

| Élément | Détail |
|---|---|
| **Système d'exploitation** | Debian Linux — utilisateur `mthiam` |
| **Outils** | VS Code · Terminal · Git |
| **Dépôt de code** | GitHub — déploiement automatisé via GitHub Actions |
| **Région AWS** | `eu-west-3` — Paris |
| **Région GCP** | `europe-west9` — Paris |
| **Région Azure** | `francecentral` — France centrale |
