# 1. Delete the cluster
gcloud container clusters delete $CLUSTER_NAME --zone $ZONE

# 2. Delete the container image in the repository
gcloud artifacts docker images delete $REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$IMAGE

# 3. Delete the artifact repository
gcloud artifacts repositories delete $REPO_NAME --location=$REGION

# 4. Delete the database instance
gcloud sql instances delete $INSTANCE_NAME

# 5. Delete the service account
gcloud iam service-accounts delete $GSA_NAME@$PROJECT_ID.iam.gserviceaccount.com