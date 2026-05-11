---
layout: default
title: Phase 02 Conteneurs
nav_order: 3
---

# Phase 02 — Conteneurs et registries

Docker, registries cloud, et services d'exécution managés sur les 3 clouds.

## AWS — ECR et ECS Fargate

Authentification ECR via `aws ecr get-login-password`, push de l'image taguée
avec l'URI du compte, déploiement via task definition ECS Fargate.

ECS Fargate alloue CPU/mémoire à la demande — pas de serveur à gérer.

## GCP — Artifact Registry et Cloud Run

Authentification via `gcloud auth configure-docker`, repository créé dans
`europe-west9`. Déploiement Cloud Run avec scaling à zéro quand pas de trafic.

`az acr build` est pratique sur GCP aussi : build directement dans le registry
sans Docker installé localement.

## Azure — ACR et ACI

Création du registry avec `az acr create`, build avec `az acr build` directement
dans le cloud. Déploiement ACI à la seconde, sans cluster à gérer.

## Comparatif

ECS Fargate est le plus flexible (réseau VPC complet) mais plus complexe à configurer.
Cloud Run est le plus simple à déployer avec le meilleur scale-to-zero.
ACI est idéal pour des conteneurs éphémères ou des jobs ponctuels.

## Ce que j'ai appris

- Chaque cloud a sa propre commande d'authentification au registry
- L'optimisation Dockerfile (multi-stage, layers) a un impact direct sur les temps de démarrage
- Cloud Run est le point d'entrée le plus accessible pour débuter avec les conteneurs cloud
