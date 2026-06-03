# AWS — Phase 05 Kubernetes (EKS)

## Cluster créé

| Champ          | Valeur                          |
|----------------|---------------------------------|
| Nom            | kgt-cluster                     |
| Outil          | eksctl                          |
| Node type      | t3.small (2 Go RAM)             |
| Nodes          | 2 (toujours présents)           |
| Région         | eu-west-3                       |
| Coût session   | ~0.25$                          |

## Pourquoi t3.small et pas t3.micro ?

t3.micro (1 Go RAM) trop petit :
- Pods système EKS (coredns, vpc-cni, kube-proxy) consomment ~400Mo
- Plus de place pour les pods applicatifs
- Erreur : Too many pods / Insufficient memory

t3.small (2 Go RAM) :
- Node 1 : 13% mémoire utilisée par les pods système
- Node 2 : 23% mémoire utilisée par les pods système
- Suffisant pour nos pods applicatifs

## Max pods par instance

| Instance  | Max pods |
|-----------|----------|
| t3.micro  | 4 pods   |
| t3.small  | 11 pods  |
| t3.medium | 17 pods  |

## Différence GKE vs EKS

| Aspect         | GKE Autopilot          | EKS t3.small                    |
|----------------|------------------------|---------------------------------|
| Nodes à vide   | 0 (à la demande)       | 2 nodes toujours présents       |
| IP publique    | IP directe             | DNS ELB                         |
| Self-healing   | ~7 secondes            | ~32 secondes                    |
| Scaling        | Instantané             | ~2 secondes                     |
| Coût à vide    | 0€                     | ~0.10$/h control plane          |

## Commandes clés

eksctl create cluster --name kgt-cluster --region eu-west-3 --node-type t3.small --nodes 2 --managed
eksctl delete cluster --name kgt-cluster --region eu-west-3 --wait

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods
kubectl get nodes
kubectl get service kgt-app-service

# Self-healing
kubectl delete pod NOM_DU_POD

# Scaling
kubectl scale deployment kgt-app --replicas=4

## Ce qu on a testé

### Self-healing
- Suppression manuelle d un pod
- Kubernetes recrée automatiquement un nouveau pod en ~32 secondes
- On revient toujours au nombre de replicas défini

### Scaling
- Passage de 2 à 4 pods avec kubectl scale
- Les 2 nouveaux pods démarrent en ~2 secondes

## LoadBalancer AWS vs GCP

GCP → IP publique directe : 34.155.186.0
AWS → DNS ELB : xxx.eu-west-3.elb.amazonaws.com

## Leçons apprises
- eksctl automatise la création du cluster et toute la config AWS (VPC, IAM, nodes)
- t3.micro trop petit pour EKS - utiliser minimum t3.small
- EKS coûte même à vide contrairement à GKE Autopilot
- Les manifests YAML sont les mêmes que GKE - seule l image change
- AWS utilise un DNS ELB au lieu d une IP publique directe
- Toujours supprimer le cluster après les labs pour éviter les frais
