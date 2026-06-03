---
layout: default
title: Phase 05 Kubernetes
nav_order: 6
---
# Phase 05 — Kubernetes sur les 3 clouds

Kubernetes est un orchestrateur de conteneurs open source qui automatise
le déploiement, la mise à l'échelle et la gestion des applications conteneurisées.
Il repose sur des objets déclaratifs — **Deployment** (état désiré),
**Pod** (unité d'exécution), **Service** (exposition réseau) — que le cluster
réconcilie en permanence avec l'état réel.

---

## Bilan de la phase

| Critère | GKE (GCP) | EKS (AWS) | AKS (Azure) |
|---|---|---|---|
| **Outil de création** | gcloud container clusters create | eksctl create cluster | az aks create |
| **Type de node** | e2-medium (Autopilot) | t3.small | Standard_D2s_v3 |
| **Nodes** | 2 | 2 | 1 (quota Free Trial) |
| **LoadBalancer** | IP publique directe | DNS ELB | IP publique directe |
| **Self-healing** | ✅ Testé | ✅ Testé | ✅ Testé |
| **Scaling** | ✅ Testé | ✅ Testé | ✅ Testé |
| **Coût estimé** | ~0.10$ | ~0.25$ | ~0.15€ |

---

## GCP — GKE (Google Kubernetes Engine)

**GKE** est le service Kubernetes managé de GCP. Il est réputé pour sa
maturité — Google a inventé Kubernetes — et son intégration native avec
les services GCP. Le mode Autopilot gère automatiquement les nodes,
ce qui simplifie la gestion de l'infrastructure.

Créer le cluster :

    gcloud container clusters create gke-lab \
      --zone europe-west9-a \
      --num-nodes 2 \
      --machine-type e2-medium

Récupérer les credentials kubectl :

    gcloud container clusters get-credentials gke-lab \
      --zone europe-west9-a

Déployer l'application :

    kubectl apply -f PHASES/05-kubernetes/GCP/deployment.yaml
    kubectl apply -f PHASES/05-kubernetes/GCP/service.yaml

GKE expose le LoadBalancer avec une **IP publique directe** — accessible
immédiatement après provisionnement.

---

## AWS — EKS (Elastic Kubernetes Service)

**EKS** est le service Kubernetes managé d'AWS. Il s'appuie sur `eksctl`,
un outil CLI dédié qui automatise la création du cluster, du VPC, des
groupes IAM et des nodes. Le LoadBalancer EKS expose un **DNS ELB**
au lieu d'une IP publique directe.

Créer le cluster :

    eksctl create cluster \
      --name eks-lab \
      --region eu-west-3 \
      --nodegroup-name standard-workers \
      --node-type t3.small \
      --nodes 2

Récupérer les credentials kubectl :

    aws eks update-kubeconfig --name eks-lab --region eu-west-3

Déployer l'application :

    kubectl apply -f PHASES/05-kubernetes/AWS/deployment.yaml
    kubectl apply -f PHASES/05-kubernetes/AWS/service.yaml

Point d'attention : `t3.micro` est trop petit pour EKS — utiliser minimum
`t3.small`. EKS facture le control plane même à vide (~0.10$/h).

---

## Azure — AKS (Azure Kubernetes Service)

**AKS** est le service Kubernetes managé d'Azure. La création passe par
`az aks create`. Le control plane AKS est **gratuit** — seuls les nodes
sont facturés. Contrainte Free Trial : les quotas vCPU sont stricts par
famille de VM — utiliser `az vm list-usage` pour vérifier avant de créer.

Créer le cluster :

    az aks create \
      --resource-group rg-aks-lab \
      --name aks-lab \
      --node-count 1 \
      --node-vm-size Standard_D2s_v3 \
      --generate-ssh-keys

Récupérer les credentials kubectl :

    az aks get-credentials --resource-group rg-aks-lab --name aks-lab

Déployer l'application :

    kubectl apply -f PHASES/05-kubernetes/AZURE/deployment.yaml
    kubectl apply -f PHASES/05-kubernetes/AZURE/service.yaml

AKS expose le LoadBalancer avec une **IP publique directe** comme GKE.
Le Resource Group doit être supprimé manuellement après le cluster.

---

## Gestion des contextes kubectl

Chaque `get-credentials` ajoute un contexte dans `~/.kube/config`.
kubectl utilise toujours le contexte courant par défaut.

Voir le contexte actif :

    kubectl config current-context

Lister tous les contextes disponibles :

    kubectl config get-contexts

Switcher de cluster :

    kubectl config use-context <nom-du-contexte>

---

## Comparatif — LoadBalancer

| Cloud | Type d'exposition | Exemple |
|---|---|---|
| GKE | IP publique directe | 34.155.186.0 |
| EKS | DNS ELB | xxx.eu-west-3.elb.amazonaws.com |
| AKS | IP publique directe | 4.251.184.7 |

---

## Ce que j'ai appris

- Les manifests YAML Kubernetes sont identiques sur les 3 clouds —
  seule l'image et les credentials changent
- Le self-healing est fondamental — Kubernetes maintient en permanence
  le nombre de replicas défini, sans intervention manuelle
- EKS est le plus complexe à créer (eksctl + VPC + IAM) mais le plus
  flexible en production
- GKE est le plus mature et le plus simple à opérer
- AKS a le control plane gratuit mais les quotas Free Trial sont très
  restrictifs — toujours vérifier avec az vm list-usage avant de créer
- Toujours supprimer les clusters après les labs — le coût est réel
  même sans trafic
