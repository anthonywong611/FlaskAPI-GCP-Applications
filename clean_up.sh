# 0. Make sure all environment variables still exist
source workflow/0_var.sh

# 1. Delete the cluster
gcloud container clusters delete $CLUSTER_NAME --zone $ZONE --quiet

# 2. Delete the container image in the repository
gcloud artifacts docker images delete $REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$IMAGE --quiet

# 3. Delete the artifact repository
gcloud artifacts repositories delete $REPO_NAME --location=$REGION --quiet

# 4. Delete the database instance
gcloud sql instances delete $INSTANCE_NAME --quiet

# 5. Delete the service account
gcloud iam service-accounts delete $GSA_NAME@$PROJECT_ID.iam.gserviceaccount.com --quiet