# GCP — Phase 05 Kubernetes (GKE)

## Cluster créé

| Champ          | Valeur                          |
|----------------|---------------------------------|
| Nom            | kgt-cluster                     |
| Mode           | Autopilot                       |
| Région         | europe-west9                    |
| Nodes          | 0 à vide (créés à la demande)   |
| Coût à vide    | 0.00€                           |

## Fichiers Kubernetes

### deployment.yaml
- replicas : 3 pods
- image : kgt-app:v1.0 depuis Artifact Registry
- resources requests : 100m CPU / 128Mi RAM
- resources limits : 200m CPU / 256Mi RAM

### service.yaml
- type : LoadBalancer
- port externe : 80
- port interne : 8080
- IP publique : 34.155.186.0

## Commandes clés

gcloud container clusters create-auto kgt-cluster --region europe-west9
gcloud container clusters get-credentials kgt-cluster --region europe-west9
gcloud container clusters delete kgt-cluster --region europe-west9 --quiet

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods
kubectl get pods -w
kubectl get nodes
kubectl get service kgt-app-service
kubectl describe deployment kgt-app

# Self-healing - supprimer un pod
kubectl delete pod NOM_DU_POD

# Scaling
kubectl scale deployment kgt-app --replicas=5

# Supprimer les ressources
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml

## Ce qu on a testé

### Self-healing
- Suppression manuelle d un pod
- Kubernetes recrée automatiquement un nouveau pod en 7 secondes
- On revient toujours à 3 pods (replicas défini dans deployment.yaml)

### Scaling
- Passage de 3 à 5 pods avec kubectl scale
- Les 2 nouveaux pods démarrent en quelques secondes
- Bonne pratique : modifier replicas dans deployment.yaml avant de scaler

### Rolling Update
- kubectl rollout restart deployment kgt-app
- Kubernetes démarre les nouveaux pods avant de supprimer les anciens
- Zéro downtime pendant la mise à jour

## Problèmes rencontrés et solutions

| Problème           | Cause                              | Solution                           |
|--------------------|------------------------------------|------------------------------------|
| ImagePullBackOff   | Cluster sans droits Artifact Registry | Ajouter roles/artifactregistry.reader au compte de service |
| No resources found | Mode Autopilot - nodes créés à la demande | Normal - les nodes apparaissent au déploiement |

## Architecture

Internet
   -> LoadBalancer IP : 34.155.186.0 (port 80)
   -> Service kgt-app-service
   -> POD 1 kgt-app (port 8080)
   -> POD 2 kgt-app (port 8080)
   -> POD 3 kgt-app (port 8080)

## Leçons apprises
- GKE Autopilot = 0 coût à vide, nodes créés à la demande
- Pod = unité de base Kubernetes (enveloppe autour du conteneur)
- Deployment = gère le nombre de pods et le self-healing
- Service = exposition réseau avec IP stable et load balancing
- Self-healing : Kubernetes recrée un pod supprimé en quelques secondes
- Scaling : une seule commande pour changer le nombre de pods
- Rolling Update : zéro downtime lors des mises à jour
- Toujours modifier deployment.yaml avant de scaler pour garder la cohérence
