# Comparatif Phase 05 — Kubernetes

## Services Kubernetes managés

| Cloud | Service | Control Plane | Nodes à vide | Mode simple |
|-------|---------|---------------|--------------|-------------|
| AWS   | EKS     | 0.10$/h       | Payants      | Fargate     |
| GCP   | GKE     | Gratuit       | 0€ Autopilot | Autopilot   |
| Azure | AKS     | Gratuit       | Payants      | -           |

## Concepts Kubernetes

| Concept    | Description                                    |
|------------|------------------------------------------------|
| Pod        | Unité de base - enveloppe autour du conteneur  |
| Deployment | Gère le nombre de pods et le self-healing      |
| Service    | Exposition réseau avec IP stable               |
| Namespace  | Espace de travail isolé dans le cluster        |
| Node       | VM dans le cluster qui héberge les pods        |
| Cluster    | Ensemble des nodes et ressources Kubernetes    |

## Comparaison avec les services simples

| Fonctionnalité  | ECS/Cloud Run/ACI | Kubernetes GKE  |
|-----------------|-------------------|-----------------|
| Self-healing    | Partiel           | Complet         |
| Scaling auto    | Partiel           | Complet         |
| Rolling update  | Partiel           | Sans downtime   |
| Multi-cloud     | Non               | Oui             |
| Complexité      | Faible            | Elevée          |
| Contrôle        | Limité            | Total           |

## Ce qu on a fait sur GKE

| Action          | Commande                                      | Résultat        |
|-----------------|-----------------------------------------------|-----------------|
| Créer cluster   | gcloud container clusters create-auto         | Cluster Running |
| Déployer app    | kubectl apply -f deployment.yaml              | 3 pods Running  |
| Exposer app     | kubectl apply -f service.yaml                 | IP publique     |
| Self-healing    | kubectl delete pod NOM                        | Pod recréé en 7s|
| Scaling         | kubectl scale deployment kgt-app --replicas=5 | 5 pods Running  |
| Supprimer       | gcloud container clusters delete              | 0.00€ de coût   |

## Leçons apprises
- Kubernetes est plus complexe mais beaucoup plus puissant
- GKE Autopilot est le mode le plus simple pour apprendre
- Le self-healing est automatique et très rapide
- Le scaling ne modifie pas le fichier deployment.yaml - bonne pratique de le faire manuellement
- Kubernetes est le standard de facto en entreprise pour les conteneurs
- EKS et AKS sont à faire en prochaine étape
