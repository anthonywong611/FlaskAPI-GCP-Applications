# --- Project Info --- #
export PROJECT_ID='<project-id>'  # TODO: Replace these values
export REGION='<region>'  # TODO: Replace these values 
export ZONE='<zone>'  # TODO: Replace these values
export WORKING_DIR=$(pwd)

# --- Database Instance Info --- #
export INSTANCE_HOST='127.0.0.1'
export INSTANCE_NAME='<instance-name>'  # TODO: Replace these values
export DB_USER='<user-name>'  # TODO: Replace these values
export DB_PASS='<password>'  # TODO: Replace these values
export DB_NAME='<database-name>'  # TODO: Replace these values
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

