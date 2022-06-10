# Create a single node GKE Cluster
# Enable Workload Identity on the cluster
gcloud container clusters create $CLUSTER_NAME \
--num-nodes=1 \
--zone=$ZONE \

gcloud container clusters get-credentials $CLUSTER_NAME \
--zone=$ZONE
