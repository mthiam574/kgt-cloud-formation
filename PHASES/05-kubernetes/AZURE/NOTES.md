# AKS — Azure Kubernetes Service

## Cluster créé
- Outil : az aks create
- Node : 1x Standard_D2s_v3 (quota Free Trial limité)
- Région : francecentral
- Kubernetes : v1.34.7

## Contraintes Free Trial Azure
- Standard_B2s non autorisé (ancienne génération)
- Standard_B2s_v2 quota 0 vCPU
- Solution : Standard_D2s_v3, 1 seul node (quota total 10 vCPUs)

## Déploiement
- Image : gcr.io/google-samples/hello-app:1.0
- Pas d'ACR (supprimé - coût 2.50€/mois)
- 2 replicas initiaux

## Tests validés
- App accessible : http://4.251.184.7 → Hello, world! v1.0.0
- Self-healing : pod supprimé, recréé en ~5 secondes
- Scaling : 2 → 4 pods en ~40 secondes

## LoadBalancer Azure vs GCP vs AWS
- GKE → IP publique directe : 34.155.186.0
- EKS → DNS ELB : xxx.eu-west-3.elb.amazonaws.com
- AKS → IP publique directe : 4.251.184.7

## Commandes clés
az aks create / az aks get-credentials / az aks delete
kubectl config current-context / kubectl config get-contexts

## Leçons apprises
- Free Trial Azure impose des quotas vCPU stricts par famille de VM
- az vm list-usage permet de voir les quotas disponibles avant de créer
- AKS fournit une IP publique directe comme GKE (pas de DNS comme EKS)
- kubectl pointe sur le bon cluster via ~/.kube/config et le contexte courant
- Toujours supprimer le cluster après les labs
