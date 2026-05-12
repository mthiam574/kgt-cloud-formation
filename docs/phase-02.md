---
layout: default
title: Phase 02 Conteneurs
nav_order: 3
---

# Phase 02 — Conteneurs et registres d'images

Containerisation d'une application avec Docker, stockage des images dans les
registres des trois clouds, et déploiement sur les services d'exécution managés.
Un conteneur est un environnement isolé et portable qui embarque l'application
et toutes ses dépendances.

---

## Bilan de la phase

| Étape | AWS | GCP | Azure |
|---|---|---|---|
| **Registre d'images** | ECR — Elastic Container Registry | Artifact Registry | ACR — Azure Container Registry |
| **Service d'exécution** | ECS Fargate — Elastic Container Service | Cloud Run | ACI — Azure Container Instances |
| **Authentification registre** | Token temporaire via AWS CLI | gcloud configure-docker | Token via az CLI |
| **Modèle de facturation** | À la tâche active | À la requête — scale to zero | À la seconde de conteneur actif |

---

## Application déployée

L'application utilisée est une application Python Flask simple — un serveur
web qui répond sur le port 8080. Elle est définie dans `PHASES/02-conteneurs/APP/`.

    PHASES/02-conteneurs/APP/
      app.py                ← application Python Flask
      Dockerfile            ← instructions de build de l'image
      task-definition.json  ← définition de tâche ECS pour AWS

Construction de l'image en local sur Debian :

    docker build -t kgt-app:v1.0 .

Test local avant push vers les registres cloud :

    docker run -p 8080:8080 kgt-app:v1.0

Vérification que le conteneur tourne :

    docker ps
    docker logs <container_id>

---

## AWS — ECR et ECS Fargate

**ECR — Elastic Container Registry** est le service de stockage d'images Docker AWS.
**ECS — Elastic Container Service** avec le mode **Fargate** exécute des conteneurs
sans gérer de serveurs — AWS alloue CPU et mémoire à la demande.

Authentification au registre ECR :

    aws ecr get-login-password --region eu-west-3 \
      | docker login --username AWS \
        --password-stdin 774941661781.dkr.ecr.eu-west-3.amazonaws.com

Création du registre ECR :

    aws ecr create-repository \
      --repository-name kgt-app \
      --region eu-west-3

Tag de l'image avec l'URI du registre ECR :

    docker tag kgt-app:v1.0 \
      774941661781.dkr.ecr.eu-west-3.amazonaws.com/kgt-app:v1.0

Push de l'image vers ECR :

    docker push \
      774941661781.dkr.ecr.eu-west-3.amazonaws.com/kgt-app:v1.0

Vérification de l'image dans ECR :

    aws ecr list-images --repository-name kgt-app --region eu-west-3

Le déploiement ECS Fargate utilise une task definition — un fichier JSON qui
décrit le conteneur, le CPU, la mémoire et les ports. Ce fichier est dans
`PHASES/02-conteneurs/APP/task-definition.json`.

---

## GCP — Artifact Registry et Cloud Run

**Artifact Registry** est le service de stockage d'artefacts GCP — il remplace
l'ancien Container Registry. **Cloud Run** exécute des conteneurs sans serveur,
avec un scaling automatique jusqu'à zéro quand il n'y a pas de trafic.

Configuration de l'authentification Docker vers Artifact Registry :

    gcloud auth configure-docker europe-west9-docker.pkg.dev

Création du registre Artifact Registry :

    gcloud artifacts repositories create kgt-repo \
      --repository-format=docker \
      --location=europe-west9 \
      --description="Registre de formation"

Tag de l'image avec l'URI Artifact Registry :

    docker tag kgt-app:v1.0 \
      europe-west9-docker.pkg.dev/project-c2ec1119-b53b-4de5-a77/kgt-repo/kgt-app:v1.0

Push de l'image vers Artifact Registry :

    docker push \
      europe-west9-docker.pkg.dev/project-c2ec1119-b53b-4de5-a77/kgt-repo/kgt-app:v1.0

Déploiement sur Cloud Run :

    gcloud run deploy kgt-app \
      --image europe-west9-docker.pkg.dev/project-c2ec1119-b53b-4de5-a77/kgt-repo/kgt-app:v1.0 \
      --region europe-west9 \
      --platform managed \
      --port 8080 \
      --allow-unauthenticated

Vérification du service :

    gcloud run services list --region europe-west9
    gcloud run services describe kgt-app --region europe-west9

---

## Azure — ACR et ACI

**ACR — Azure Container Registry** est le registre d'images Azure.
**ACI — Azure Container Instances** déploie des conteneurs à la demande
sans cluster ni serveur à gérer, avec une facturation à la seconde.

Création du groupe de ressources et du registre ACR :

    az group create --name kgt-formation --location francecentral

    az acr create \
      --resource-group kgt-formation \
      --name kgtformationregistry \
      --sku Basic \
      --admin-enabled true

Build de l'image directement dans ACR sans Docker local :

    az acr build \
      --registry kgtformationregistry \
      --image kgt-app:v1.0 .

Vérification de l'image dans ACR :

    az acr repository list --name kgtformationregistry --output table

Déploiement sur ACI :

    az container create \
      --resource-group kgt-formation \
      --name kgt-app \
      --image kgtformationregistry.azurecr.io/kgt-app:v1.0 \
      --registry-login-server kgtformationregistry.azurecr.io \
      --registry-username $(az acr credential show --name kgtformationregistry --query username -o tsv) \
      --registry-password $(az acr credential show --name kgtformationregistry --query passwords[0].value -o tsv) \
      --cpu 1 \
      --memory 1 \
      --ports 8080

Vérification et logs du conteneur :

    az container show --resource-group kgt-formation --name kgt-app --output table
    az container logs --resource-group kgt-formation --name kgt-app

---

## Comparatif des services d'exécution

| Critère | ECS Fargate | Cloud Run | ACI |
|---|---|---|---|
| **Modèle** | Service persistant | Scale to zero | Conteneur éphémère |
| **Complexité** | Élevée — task definition JSON | Faible — une commande | Faible — une commande |
| **Coût sans trafic** | Oui — tâche toujours active | Non — scale to zero | Non — facturation à la seconde |
| **Réseau VPC** | Complet | Limité | Limité |
| **Cas d'usage** | Applications persistantes | APIs et services web | Jobs ponctuels, tests |

---

## Ce que j'ai appris

- Le token d'authentification ECR expire après 12 heures — il faut le renouveler
  à chaque session avec `aws ecr get-login-password`
- `az acr build` construit l'image directement dans Azure sans avoir besoin
  de Docker installé localement — pratique et différent des deux autres clouds
- Cloud Run est le plus simple à déployer et le plus économique pour une charge
  variable grâce au scale to zero
- La commande `docker tag` ne copie pas l'image — elle crée un alias pointant
  vers la même image avec un nom différent
