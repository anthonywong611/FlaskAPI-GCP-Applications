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

# --- Kubernetes Cluster Info --- #
export CLUSTER_NAME='flask-cluster'

# --- Connection Info --- #
export GSA_NAME='gke-sql-iam-sa'  
export DB_SECRET='db-secret'
export SA_SECRET='sa-secret'

# --- Container Info --- #
export REPO_NAME=flask-repo
export IMAGE=cloudsql-to-gke