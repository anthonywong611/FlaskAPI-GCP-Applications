export GSA_NAME='gke-sql-iam-sa'  
export DB_SECRET='db-secret'
export SA_SECRET='sa-secret'

# 1. Create a GSA for the project
gcloud iam service-accounts create $GSA_NAME \
--description="Working with Cloud SQL database instances" \
--display-name=$GSA_NAME

# 2. Grant Cloud SQL Client role to the GSA
gcloud projects add-iam-policy-binding $PROJECT_ID \
--member="serviceAccount:$GSA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
--role="roles/cloudsql.client"

# 3. Generate service accont key for the Cloud SQL Auth proxy pod
gcloud iam service-accounts keys create key.json \
--iam-account=$GSA_NAME@$PROJECT_ID.iam.gserviceaccount.com

# 4. Setting secrets for connecting to CloudSQL from GKE
# 4.1. Database Secrets
kubectl create secret generic $DB_SECRET \
--from-literal=username=$DB_USER \
--from-literal=password=$DB_PASS \
--from-literal=database=$DB_NAME

# 4.2. Service Account Secret
kubectl create secret generic $SA_SECRET \
--from-file=service_account.json=key.json

rm key.json

# ---------------------------------------------------------------- #

# --- Create a Kubernetes Service Account (KSA) and Configure ---- #
# --------- application to act as an IAM service account --------- #

# # 1. Create a namespace for the Kubernetes Serivce Account (KSA)
# kubectl create namespace $NAMESPACE

# # 2. Create a KSA for the app in the namespace
# kubectl create serviceaccount $KSA_NAME --namespace=$NAMESPACE

# # Apply this updated configuration to the GKE cluster
# kubectl apply -f ../paas-on-gcp/service-account.yaml

# # 3. Enable IAM binding between GSA and KSA
# gcloud iam service-accounts add-iam-policy-binding \
# --role="roles/iam.workloadIdentityUser" \
# --member="serviceAccount:$PROJECT_ID.svc.id.goog[$NAMESPACE/$KSA_NAME]" \
# $GSA_NAME@$PROJECT_ID.iam.gserviceaccount.com

# # 4. Annotate the KSA with the GSA email address to complete binding
# kubectl annotate serviceaccount $KSA_NAME \
# --namespace=$NAMESPACE \
# iam.gek.io/gcp-service-account=$GSA_NAME@$PROJECT_ID.iam.gserviceaccount.com 

# ---------------------------------------------------------------- #





