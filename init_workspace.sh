#!/bin/bash
# ~/FORMATIONS/CLOUD/init_workspace.sh

PHASES="01-fondations 02-conteneurs 03-cicd-iac 04-observabilite"
CLOUDS="AWS GCP AZURE"

for phase in $PHASES; do
  for cloud in $CLOUDS; do
    mkdir -p PHASES/$phase/$cloud/{SCRIPTS,TRACES}
    touch PHASES/$phase/$cloud/NOTES.md
  done
  touch PHASES/$phase/COMPARATIF.md
done

mkdir -p DIAGRAMS SCRIPTS TERRAFORM/{aws,gcp,azure}
touch SCRIPTS/{aws-setup.sh,gcp-setup.sh,azure-setup.sh}
chmod +x SCRIPTS/*.sh

echo "Workspace CLOUD initialisé ✓"
