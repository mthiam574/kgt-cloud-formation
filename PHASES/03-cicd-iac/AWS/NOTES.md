# AWS — Phase 03 CI/CD & IaC

## Partie 1 — Terraform

### Fichiers
| Fichier           | Rôle                                |
|-------------------|-------------------------------------|
| main.tf           | Ressources à créer                  |
| variables.tf      | Paramètres configurables            |
| outputs.tf        | Valeurs affichées après apply       |
| terraform.tfstate | Mémoire de l état (ne pas commiter) |

### Ressources créées
| Ressource       | Nom                | Détail            |
|-----------------|--------------------|-------------------|
| Security Group  | kgt-app-sg-tf      | Port 8080 ouvert  |
| Cluster ECS     | kgt-formation-tf   | Cluster Fargate   |
| Task Definition | kgt-app-tf         | 0.25 vCPU / 512Mo |
| Service ECS     | kgt-app-service-tf | desired-count=1   |

### Commandes
terraform init / plan / apply / destroy

## Partie 2 — GitHub Actions CI/CD

### Fichier pipeline
.github/workflows/deploy-aws.yml

### Trigger
Push sur branche main avec modifications dans PHASES/02-conteneurs/APP/

### Secrets GitHub requis
| Secret               | Valeur              |
|----------------------|---------------------|
| AWS_ACCESS_KEY_ID    | Clé IAM formation-cli |
| AWS_SECRET_ACCESS_KEY| Clé secrète IAM     |
| AWS_REGION           | eu-west-3           |

### Étapes du pipeline
| Étape                | Rôle                              | CI/CD |
|----------------------|-----------------------------------|-------|
| checkout             | Télécharge le code                | CI    |
| configure-aws        | Authentification AWS              | CI    |
| login-ecr            | Authentification Docker sur ECR   | CI    |
| build-and-push       | Build et push image sur ECR       | CI    |
| deploy-ecs           | Mise à jour service ECS           | CD    |

### Résultats
| Version | Tag image        | Durée | Type  |
|---------|------------------|-------|-------|
| v2.0    | hash commit      | 26s   | CI    |
| v3.0    | hash commit      | 28s   | CI/CD |

## Leçons apprises
- CI = build + test + push artefact (image Docker)
- CD = déploiement automatique de l artefact
- La frontière CI/CD = quand l image est prête sur ECR
- github.sha donne un tag unique par commit
- --force-new-deployment force ECS à utiliser la nouvelle image
- Ne jamais commiter terraform.tfstate dans Git
