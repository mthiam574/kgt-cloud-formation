---
layout: default
title: Phase 01 Fondations
nav_order: 2
---

# Phase 01 — Fondations cloud

Mise en place de l'environnement de travail complet : installation des CLI
(Command Line Interface — interface en ligne de commande) des trois clouds,
configuration des authentifications, et activation des alertes budget.

---

## Bilan de la phase

| Objectif | AWS | GCP | Azure |
|---|---|---|---|
| CLI installé | ✅ aws-cli v2.34.45 | ✅ gcloud SDK 567.0.0 | ✅ az CLI 2.86.0 |
| Authentification | ✅ Clés statiques IAM | ✅ OAuth2 gcloud | ✅ OAuth2 az login |
| Région européenne | ✅ eu-west-3 Paris | ✅ europe-west9 Paris | ✅ francecentral |
| Alerte budget | ✅ Zero-spend + 5 USD | ✅ 5 EUR | ✅ 5 EUR |

---

## AWS — Amazon Web Services

**Account ID** : 774941661781
**Région** : eu-west-3 (Paris)
**Identité CLI** : utilisateur IAM (Identity and Access Management) `formation-cli`

Sur AWS, le CLI s'authentifie avec des **clés statiques** : une Access Key ID
et une Secret Access Key générées depuis la console IAM. Ces clés sont stockées
localement dans `~/.aws/credentials`.

Le principe est de ne jamais utiliser le compte root — un utilisateur IAM dédié
à la formation avec la policy `AdministratorAccess` a été créé à la place.

Installation du CLI AWS version 2 sur Debian :

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

Configuration avec les clés IAM :

    aws configure
    # AWS Access Key ID     : (clé générée dans IAM → Users → formation-cli → Security credentials)
    # AWS Secret Access Key : (clé secrète associée)
    # Default region name   : eu-west-3
    # Default output format : json

Vérification de l'identité connectée :

    aws sts get-caller-identity

Vérification de la configuration active :

    aws configure list

Les fichiers de configuration sont stockés dans :

    ~/.aws/credentials   ← clés Access Key ID et Secret
    ~/.aws/config        ← région et format de sortie

Alertes budget configurées :
- Zero-spend : seuil à 0.01 USD — alerte dès le premier centime dépensé
- Mensuel : seuil à 5 USD — notification par email

---

## GCP — Google Cloud Platform

**Projet** : project-c2ec1119-b53b-4de5-a77
**Région** : europe-west9 (Paris)
**Identité CLI** : compte Google personnel via OAuth2

Sur GCP, `gcloud auth login` ouvre une page web et utilise le compte Google
directement — pas de clés à générer ni à stocker. C'est un flux OAuth2
(Open Authorization) : un token temporaire est créé localement.

Installation du gcloud CLI sur Debian :

    curl https://sdk.cloud.google.com | bash
    exec -l $SHELL

Authentification et configuration du projet :

    gcloud auth login
    # Ouvre le navigateur → connexion avec le compte Google → token stocké localement

    gcloud config set project project-c2ec1119-b53b-4de5-a77
    gcloud config set compute/region europe-west9

Vérification du compte et de la configuration :

    gcloud auth list
    gcloud config list

La configuration est stockée dans `~/.config/gcloud/`.

Alerte budget configurée à 5 EUR via la console Cloud Billing avec notification par email.

---

## Azure — Microsoft Azure

**Subscription** : a8d50b8a-bf03-4c94-9e50-1510888d02e4
**Région** : francecentral
**Identité CLI** : compte Microsoft externe via OAuth2

Azure fonctionne comme GCP : `az login` ouvre le navigateur et authentifie
via le compte Microsoft. Le compte utilisé (`kgttechnologies74@gmail.com`)
est un **compte externe** (Microsoft Account) rattaché au tenant Azure — visible
dans Microsoft Entra ID (anciennement Azure Active Directory) sous
"Inscriptions d'applications → Utilisateurs".

Particularité : Azure ne crée pas de clés statiques pour l'utilisateur humain.
Le token OAuth2 est valide 1 heure et se renouvelle automatiquement.
La configuration est stockée dans `~/.azure/`.

Installation du CLI Azure sur Debian :

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

Authentification et sélection de la subscription :

    az login
    # Ouvre le navigateur → connexion avec le compte Microsoft → token stocké dans ~/.azure/

    az account set --subscription a8d50b8a-bf03-4c94-9e50-1510888d02e4

Vérification de la subscription active :

    az account show
    az account list --output table

Alerte budget configurée à 5 EUR via Azure Cost Management avec notification par email.

---

## Comparatif — Authentification CLI

| Critère | AWS | GCP | Azure |
|---|---|---|---|
| **Mécanisme** | Clés statiques (Access Key + Secret Key) | OAuth2 — token temporaire | OAuth2 — token temporaire |
| **Stockage local** | `~/.aws/credentials` | `~/.config/gcloud/` | `~/.azure/` |
| **Durée de validité** | Illimitée (rotation manuelle recommandée tous les 90 jours) | Renouvelé automatiquement | 1 heure, renouvelé automatiquement |
| **Risque de fuite** | Élevé si clés mal gérées | Faible — pas de clé statique | Faible — pas de clé statique |
| **Identité utilisée** | Utilisateur IAM `formation-cli` | Compte Google personnel | Compte Microsoft externe |
| **Console web** | console.aws.amazon.com → IAM | console.cloud.google.com | portal.azure.com → Entra ID |

---

## Difficultés rencontrées

**Clés AWS à sécuriser** — les clés statiques AWS sont les credentials les plus
sensibles de la formation. Stockées dans Bitwarden, jamais dans le code,
jamais dans un dépôt Git.

**Droits IAM insuffisants** — le premier utilisateur IAM n'avait pas les droits
pour créer des budgets. Résolution : ajout de la policy `AWSBudgetsFullAccess`
depuis la console IAM.

**GCP Free Trial** — bloque la création de clés JSON pour les comptes de service
(Service Account). Cela impactera la phase CI/CD GCP. Solution identifiée :
Workload Identity Federation — permet à GitHub Actions de s'authentifier
sur GCP sans clé JSON.

---

## Ce que j'ai appris

- AWS, GCP et Azure ont des approches très différentes sur l'authentification CLI :
  clés statiques sur AWS, OAuth2 sur GCP et Azure
- Les clés statiques AWS demandent plus de discipline (rotation, stockage sécurisé)
  que les tokens OAuth2 qui se gèrent automatiquement
- Configurer les alertes budget **avant** de lancer les premiers labs est
  indispensable — la règle du zero-spend sur AWS est particulièrement utile
