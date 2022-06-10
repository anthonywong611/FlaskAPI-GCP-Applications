# Project Setup
gcloud config set project $PROJECT_ID 
gcloud config set compute/zone $ZONE
gcloud config set compute/region $REGION

# Enable Relevant Services
gcloud services enable \
compute.googleapis.com \
container.googleapis.com \
sqladmin.googleapis.com \
cloudbuild.googleapis.com \
artifactregistry.googleapis.com \
iam.googleapis.com

