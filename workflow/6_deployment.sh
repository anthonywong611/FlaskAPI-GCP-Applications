# Deploy the resource to the GKE cluster
kubectl apply -f deployment.yaml

# Create the service to expose deployment
kubectl apply -f service.yaml 