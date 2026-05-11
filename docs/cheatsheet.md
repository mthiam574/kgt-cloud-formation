---
layout: default
title: Cheatsheet
nav_order: 8
---

# Cheatsheet — Commandes essentielles

Toutes les commandes utilisées pendant la formation, pretes a copier-coller.

---

## AWS CLI

    # Identite et profil
    aws sts get-caller-identity --profile formation
    aws configure list --profile formation

    # ECR
    aws ecr get-login-password --region eu-west-3 --profile formation \
      | docker login --username AWS \
        --password-stdin 774941661781.dkr.ecr.eu-west-3.amazonaws.com

    aws ecr create-repository --repository-name mon-app --region eu-west-3 --profile formation
    aws ecr list-images --repository-name mon-app --region eu-west-3 --profile formation

    # ECS
    aws ecs list-clusters --region eu-west-3 --profile formation
    aws ecs list-services --cluster mon-cluster --region eu-west-3 --profile formation
    aws ecs describe-services --cluster mon-cluster --services mon-service --region eu-west-3 --profile formation

    # CloudWatch
    aws cloudwatch describe-alarms --profile formation
    aws logs describe-log-groups --profile formation

    # Budget
    aws budgets describe-budgets --account-id 774941661781 --profile formation

---

## GCP CLI

    # Identite et projet
    gcloud auth list
    gcloud config list
    gcloud config set project project-c2ec1119-b53b-4de5-a77

    # Artifact Registry
    gcloud auth configure-docker europe-west9-docker.pkg.dev
    gcloud artifacts repositories list --location=europe-west9
    gcloud artifacts docker images list europe-west9-docker.pkg.dev/project-c2ec1119-b53b-4de5-a77/formation-repo

    # Cloud Run
    gcloud run services list --region europe-west9
    gcloud run services describe mon-app --region europe-west9
    gcloud run deploy mon-app --image IMAGE_URI --region europe-west9 --platform managed

    # Logs
    gcloud logging read "resource.type=cloud_run_revision" --limit 50

---

## Azure CLI

    # Identite et subscription
    az account show
    az account set --subscription a8d50b8a-bf03-4c94-9e50-1510888d02e4

    # ACR
    az acr list --output table
    az acr build --registry formationacr --image mon-app:v1 .
    az acr repository list --name formationacr

    # ACI
    az container list --output table
    az container show --resource-group formation-rg --name mon-app
    az container logs --resource-group formation-rg --name mon-app

    # Monitor
    az monitor alert list --output table

---

## Docker

    # Build et test local
    docker build -t mon-app:v1 .
    docker images
    docker run -p 8080:80 mon-app:v1
    docker ps
    docker logs CONTAINER_ID

    # Nettoyage
    docker system prune -f
    docker image prune -a

---

## Terraform

    terraform init
    terraform validate
    terraform plan
    terraform plan -out=tfplan
    terraform apply tfplan
    terraform apply -auto-approve
    terraform destroy
    terraform state list
    terraform output

---

## Git et GitHub Actions

    git status
    git add -A
    git commit -m "feat: description"
    git push origin main

    # Voir les workflows depuis le CLI GitHub
    gh workflow list
    gh run list
    gh run view RUN_ID
