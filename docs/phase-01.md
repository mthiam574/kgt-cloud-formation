---
layout: default
title: Phase 01 Fondations
nav_order: 2
---

# Phase 01 — Fondations cloud

Mise en place de l'environnement de travail complet : installation des interfaces
en ligne de commande (CLI — Command Line Interface), configuration des trois comptes
cloud avec des utilisateurs dédiés à la formation, et activation des alertes budget
sur chaque cloud pour maîtriser les coûts dès le départ.

---

## Objectifs de la phase

| Objectif | AWS | GCP | Azure |
|---|---|---|---|
| CLI installé et configuré | ✅ aws-cli v2 | ✅ gcloud CLI | ✅ az CLI |
| Utilisateur dédié formation | ✅ IAM formation-cli | ✅ Service Account | ✅ Service Principal |
| Région européenne configurée | ✅ eu-west-3 Paris | ✅ europe-west9 Paris | ✅ francecentral |
| Alerte budget activée | ✅ 5 USD via SNS | ✅ 5 EUR via Billing | ✅ 5 EUR via Cost Management |

---

## AWS — Amazon Web Services

**Compte** : 774941661781
**Région** : eu-west-3 (Paris)
**Utilisateur IAM** : formation-cli

IAM (Identity and Access Management) est le service AWS qui gère les identités
et les droits d'accès. Plutôt que d'utiliser le compte root, un utilisateur IAM
dédié avec des droits limités au périmètre de la formation a été créé.

Installation de l'AWS CLI (Command Line Interface) version 2 sur Debian :

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip && sudo ./aws/install

Configuration du profil formation :

    aws configure --profile formation
    # Renseigner : Access Key ID, Secret Access Key, région eu-west-3, format json

Vérification de l'identité connectée :

    aws sts get-caller-identity --profile formation

Alerte budget configurée à 5 USD avec notification via SNS (Simple Notification Service)
vers une adresse email.

---

## GCP — Google Cloud Platform

**Projet** : project-c2ec1119-b53b-4de5-a77
**Région** : europe-west9 (Paris)
**Authentification** : compte de service (Service Account) formation-sa

Sur GCP, les droits sont gérés via des comptes de service (Service Account) auxquels
on attribue des rôles précis. Le principe est le même qu'IAM sur AWS : ne jamais
utiliser le compte propriétaire pour les opérations quotidiennes.

Installation du gcloud CLI sur Debian :

    curl https://sdk.cloud.google.com | bash
    exec -l $SHELL

Initialisation et configuration du projet :

    gcloud init
    gcloud config set project project-c2ec1119-b53b-4de5-a77
    gcloud config set compute/region europe-west9

Vérification de la configuration active :

    gcloud auth list
    gcloud config list

Alerte budget configurée à 5 EUR via la console Cloud Billing avec notification par email.

---

## Azure — Microsoft Azure

**Subscription** : a8d50b8a-bf03-4c94-9e50-1510888d02e4
**Région** : francecentral
**Authentification** : Service Principal dédié formation

Azure utilise le concept de Service Principal — l'équivalent du compte de service GCP
et de l'utilisateur IAM AWS — pour authentifier les outils et scripts sans utiliser
les credentials personnels.

Installation de l'Azure CLI sur Debian :

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

Connexion et sélection de la subscription :

    az login
    az account set --subscription a8d50b8a-bf03-4c94-9e50-1510888d02e4

Vérification de la subscription active :

    az account show

Alerte budget configurée à 5 EUR via Azure Cost Management avec notification par email.

---

## Comparatif — Gestion des identités

| Concept | AWS | GCP | Azure |
|---|---|---|---|
| **Service de gestion des identités** | IAM — Identity and Access Management | IAM — Identity and Access Management | Azure Active Directory |
| **Entité d'authentification pour les outils** | Utilisateur IAM | Compte de service (Service Account) | Service Principal |
| **Droits attribués via** | Policies JSON | Rôles prédéfinis | Rôles RBAC |
| **Authentification CLI** | Clé d'accès (Access Key) | gcloud auth login | az login |

---

## Difficultés rencontrées

**Gestion des profils AWS** — risque de confusion quand plusieurs comptes sont configurés
en parallèle. Solution : utiliser systématiquement `--profile formation` dans chaque
commande, et définir `AWS_DEFAULT_PROFILE=formation` dans le fichier `.bashrc`.

**Droits IAM insuffisants** — le premier utilisateur IAM créé n'avait pas les droits
pour créer des budgets. Résolution : ajout de la policy `AWSBudgetsFullAccess` via
la console IAM.

**GCP Free Trial** — la politique du compte d'essai gratuit GCP bloque la création
de clés JSON pour les comptes de service. Ce point impacte la phase CI/CD (Intégration
et Déploiement Continus) GCP. Solution identifiée : Workload Identity Federation,
qui permet à GitHub Actions de s'authentifier sur GCP sans clé JSON.

---

## Ce que j'ai appris

- Le principe du **moindre privilège** (least privilege) : créer des identités avec
  uniquement les droits nécessaires, jamais plus — applicable sur les trois clouds
- Chaque cloud a sa propre terminologie mais la logique est identique : une entité
  dédiée, des droits limités, une traçabilité des actions
- Configurer les alertes budget **avant** de lancer les premiers labs est indispensable
  pour éviter les mauvaises surprises sur un compte de formation
