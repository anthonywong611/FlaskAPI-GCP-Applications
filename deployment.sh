# Deploy the resource to the GKE cluster
kubectl apply -f deployment.yaml

# Create the service
kubectl apply -f service.yaml 

# Get the external IP address of the service
kubectl get services