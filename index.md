---
layout: home
title: Accueil
nav_order: 1
---

# Formation DevOps Cloud — Moustapha THIAM
{: .fs-9 }

Admin sys Linux en reconversion DevOps Cloud. Ce site documente une formation pratique
multi-cloud construite de zéro : infrastructure, conteneurs, IaC, CI/CD, et observabilité.
{: .fs-5 .fw-300 }

[Voir la progression →](docs/progress.md){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[GitHub ↗](https://github.com/mthiam574/kgt-cloud-formation){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## Stack couverte

| Cloud | Services pratiqués |
|---|---|
| **AWS** | IAM · ECR · ECS Fargate · CloudWatch · Terraform · GitHub Actions |
| **GCP** | Artifact Registry · Cloud Run · Cloud Monitoring · Terraform |
| **Azure** | ACR · ACI · Azure Monitor · Terraform · GitHub Actions |

---

## Phases

| Phase | Thème | Statut |
|---|---|---|
| [01 — Fondations](docs/phase-01.md) | CLIs · IAM · Budget alerts | ✅ Terminé |
| [02 — Conteneurs](docs/phase-02.md) | Docker · Registries · Run services | ✅ Terminé |
| [03 — IaC & CI/CD](docs/phase-03.md) | Terraform · GitHub Actions | ✅ Terminé |
| [04 — Observabilité](docs/phase-04.md) | CloudWatch · Monitoring · Alertes | ✅ Terminé |
| 05 — Kubernetes | EKS · GKE · AKS | ⏳ En cours |

---

## Environnement de travail

- **OS** : Debian Linux — utilisateur `mthiam`
- **Éditeur** : VS Code + terminal
- **Dépôt** : GitHub (privé) — CI/CD via GitHub Actions
- **Régions** : `eu-west-3` (AWS) · `europe-west9` (GCP) · `francecentral` (Azure)
