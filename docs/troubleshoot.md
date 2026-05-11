---
layout: default
title: Troubleshooting
nav_order: 9
---

# Troubleshooting — Erreurs rencontrees et solutions

Erreurs reelles rencontrees pendant la formation, avec la cause et la solution.
Cette page est mise a jour au fil des phases.

---

## AWS

### Erreur : Unable to locate credentials

Symptome : `Unable to locate credentials. You can configure credentials by running "aws configure".`

Cause : commande lancee sans specifier le profil formation.

Solution : toujours ajouter `--profile formation` ou exporter la variable :

    export AWS_DEFAULT_PROFILE=formation

---

### Erreur : AccessDenied sur les budgets

Symptome : `AccessDeniedException: User is not authorized to perform: budgets:CreateBudget`

Cause : l'utilisateur IAM `formation-cli` n'avait pas la policy budget.

Solution : attacher la policy `AWSBudgetsFullAccess` via la console IAM ou CLI :

    aws iam attach-user-policy \
      --user-name formation-cli \
      --policy-arn arn:aws:iam::aws:policy/AWSBudgetsFullAccess \
      --profile formation

---

### Erreur : ECR login expire

Symptome : `no basic auth credentials` lors d'un `docker push` vers ECR.

Cause : le token ECR expire apres 12 heures.

Solution : re-executer la commande de login ECR avant chaque session de travail.

---

## GCP

### Erreur : Creation de cles JSON bloquee

Symptome : `FAILED_PRECONDITION: Precondition check failed` lors de la creation d'une cle JSON service account.

Cause : politique de securite du compte Free Trial GCP qui interdit la creation de cles JSON.

Solution identifiee (non encore implementee) : utiliser Workload Identity Federation
pour lier GitHub Actions a GCP sans cle JSON. Permet d'eviter le stockage de credentials
dans les secrets GitHub.

---

### Erreur : Region non disponible pour Cloud Run

Symptome : `INVALID_ARGUMENT: The provided location is not supported.`

Cause : tentative de deploiement dans une region non disponible pour Cloud Run.

Solution : verifier les regions disponibles et utiliser `europe-west9` (Paris) :

    gcloud run regions list

---

## Azure

### Erreur : Subscription non selectionnee

Symptome : commandes `az` qui echouent ou travaillent sur la mauvaise subscription.

Cause : plusieurs subscriptions presentes (compte perso + formation).

Solution : toujours definir la subscription explicitement :

    az account set --subscription a8d50b8a-bf03-4c94-9e50-1510888d02e4
    az account show  # verification

---

### Erreur : ACR non attache a ACI

Symptome : `InaccessibleImage` lors du demarrage d'un container ACI.

Cause : ACI n'avait pas les droits pour puller l'image depuis ACR.

Solution : fournir les credentials ACR lors de la creation du container :

    az container create \
      --registry-login-server formationacr.azurecr.io \
      --registry-username $(az acr credential show --name formationacr --query username -o tsv) \
      --registry-password $(az acr credential show --name formationacr --query passwords[0].value -o tsv) \
      ...

---

## Terraform

### Erreur : State lock

Symptome : `Error locking state: Error acquiring the state lock`

Cause : un `terraform apply` anterieur a ete interrompu et le lock n'a pas ete libere.

Solution : identifier et supprimer le lock manuellement (selon le backend S3, GCS ou Azure Storage),
ou utiliser `terraform force-unlock LOCK_ID`.

---

### Erreur : Provider non initialise

Symptome : `Error: Could not load plugin`

Cause : `terraform init` non execute apres ajout d'un nouveau provider.

Solution : toujours executer `terraform init` apres toute modification du bloc `required_providers`.

---

## GitHub Actions

### Erreur : Secrets non trouves

Symptome : le workflow echoue avec `Error: Input required and not supplied: aws-access-key-id`

Cause : les secrets ne sont pas configures dans les Settings du depot GitHub.

Solution : aller dans Settings > Secrets and variables > Actions > New repository secret
et ajouter AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, etc.

---

### Erreur : Permissions insuffisantes sur GitHub Pages

Symptome : `Error: HttpError: Resource not accessible by integration`

Cause : les permissions du workflow ne sont pas configurees pour ecrire sur Pages.

Solution : dans le workflow YAML, ajouter explicitement :

    permissions:
      contents: read
      pages: write
      id-token: write
