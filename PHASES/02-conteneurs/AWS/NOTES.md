# AWS — Phase 02 Conteneurs

## Service utilisé : ECS Fargate
ECS est le service d'orchestration de conteneurs AWS.
Fargate = mode serverless, pas de serveur à gérer.

## Ressources créées
| Ressource       | Nom               | Détail                          |
|-----------------|-------------------|---------------------------------|
| Registre ECR    | kgt-app           | eu-west-3                       |
| Rôle IAM        | ecsTaskExecutionRole | Accès ECR pour Fargate       |
| Cluster ECS     | kgt-formation     | Vide (desired-count=0)          |
| Task Definition | kgt-app:2         | 0.25 vCPU / 512Mo / port 8080   |
| Security Group  | kgt-app-sg        | Port 8080 ouvert                |
| Service ECS     | kgt-app-service   | Arrêté                          |

## Commandes clés
# Démarrer le conteneur
aws ecs update-service --cluster kgt-formation --service kgt-app-service --desired-count 1 --region eu-west-3

# Arrêter le conteneur
aws ecs update-service --cluster kgt-formation --service kgt-app-service --desired-count 0 --region eu-west-3

## Complexité : 5 étapes — ECR + IAM + Cluster + Task Definition + Security Group + Service
