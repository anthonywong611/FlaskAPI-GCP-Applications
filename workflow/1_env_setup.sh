# --- Project Info --- #
export PROJECT_ID='data-at-anz-350321'  # TODO: Replace these values
export REGION='northamerica-northeast2'  # TODO: Replace these values 
export ZONE='northamerica-northeast2-a'  # TODO: Replace these values
export WORKING_DIR=$(pwd)

# --- Database Instance Info --- #
export INSTANCE_HOST='127.0.0.1'
export INSTANCE_NAME='instance-19'  # TODO: Replace these values
export DB_USER='anthony' 
export DB_PASS='Huangjianen611?'  # TODO: Replace these values
export DB_NAME='flask-data'  # TODO: Replace these values
export DB_PORT='5432'

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

