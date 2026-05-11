---
layout: default
title: Phase 04 Observabilite
nav_order: 5
---

# Phase 04 — Observabilité et monitoring

Mise en place de la supervision sur les 3 clouds : métriques, logs, alertes.

## AWS — CloudWatch

Configuration de dashboards CloudWatch pour visualiser les métriques ECS
(CPU, mémoire, requêtes). Création d'alarmes avec notifications SNS.

Logs centralisés dans CloudWatch Logs, groupes de logs par service,
rétention configurée à 30 jours pour maîtriser les coûts.

## GCP — Cloud Monitoring

Workspaces Cloud Monitoring, dashboards personnalisés pour Cloud Run.
Alertes sur les métriques de latence et d'erreurs 5xx.

Cloud Logging intégré nativement avec Cloud Run — les logs arrivent
automatiquement sans configuration supplémentaire.

## Azure — Azure Monitor

Azure Monitor avec Log Analytics Workspace. Métriques ACI et ACR supervisées.
Alertes configurées avec des groupes d'action (email, webhook).

Application Insights pour le monitoring applicatif (traces, dépendances, performances).

## Comparatif des approches

CloudWatch est le plus intégré avec l'écosystème AWS mais la tarification
à l'ingestion de logs peut surprendre. Cloud Logging GCP est le plus simple
à démarrer. Azure Monitor est le plus complet mais aussi le plus complexe à configurer.

## Ce que j'ai appris

- Le monitoring doit être pensé dès le départ, pas ajouté après
- Les logs non structurés sont difficiles à exploiter — préférer le format JSON
- La rétention des logs a un coût réel — configurer des politiques dès le début
- Une alerte sans runbook associé ne sert à rien
