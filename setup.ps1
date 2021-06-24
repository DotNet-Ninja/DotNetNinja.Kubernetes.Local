$version = "Kind.0.11.1"

# Install a new cluster
kind create cluster --config=.\$version\cluster-config.yaml --name ninja-k8s

# Add nginx ingress controller
Write-Host "Installing nginx ingress controller"
kubectl apply -f .\$version\ingress-nginx.yaml

# wait for all the ingress configuration to complete
Write-Host "Waiting for configuration tasks to complete.  (This may take a couple of minutes)."
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/component=controller -n ingress-nginx --timeout=300s
kubectl wait --for=condition=Complete job -l app.kubernetes.io/component=admission-webhook -n ingress-nginx --timeout=300s
