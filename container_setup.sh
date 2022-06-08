# Create a repository to store the container in Artifact Registry and 
# deploy it to the GKE cluster 
export REPO_NAME=flask-repo
gcloud artifacts repositories create $REPO_NAME \
--project=$PROJECT_ID \
--repository-format=docker \
--location=$REGION \
--description="Cloud SQL to GKE application"

# Make sure in the paas-on-gcp directory
# Containerize the Flask API using Cloud Build
export IMAGE=cloudsql-to-gke
gcloud builds submit \
--tag $REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$IMAGE .

# Container image stored in Artifact Registry