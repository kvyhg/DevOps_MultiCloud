#!/bin/bash

# Navigate to the project root directory
cd "$(dirname "$0")"

echo "🚀 Deploying Flask App with Prometheus Monitoring..."

# Ensure Dockerfile exists before building
if [ ! -f "app/Dockerfile" ]; then
    echo "❌ Dockerfile not found in app/ directory! Exiting..."
    exit 1
fi

# Build and start services using Docker Compose
echo "🐳 Starting Docker services..."
docker-compose up -d --build

# Verify services are running
echo "🔍 Checking running containers..."
docker ps

# Check Prometheus service
echo "🔍 Verifying Prometheus is running..."
if ! docker ps | grep -q "prometheus"; then
    echo "❌ Prometheus is not running!"
    exit 1
fi

# Minikube Setup
echo "🔍 Checking if Minikube is installed..."
if ! command -v minikube &> /dev/null
then
    echo "❌ Minikube not found! Please install it."
    exit 1
fi

echo "🚀 Starting Minikube..."
if ! minikube status | grep -q "Running"; then
    echo "❌ Minikube is not running! Restarting..."
    minikube stop
    minikube delete
    minikube start --driver=docker
fi

# Set up Docker to use Minikube’s daemon
echo "🔧 Configuring Docker for Minikube..."
eval $(minikube docker-env)

# Build the app image for Kubernetes
echo "🐳 Building app image for Kubernetes..."
docker build -t my-app:latest ./app

# Ensure Kubernetes files exist before applying
if [ ! -f "Kubernetes/deployment.yaml" ] || [ ! -f "Kubernetes/service.yaml" ]; then
    echo "❌ Kubernetes deployment/service files are missing! Exiting..."
    exit 1
fi

# Deploy application to Kubernetes
echo "📦 Deploying to Kubernetes..."
kubectl apply -f Kubernetes/deployment.yaml
kubectl apply -f Kubernetes/service.yaml

# Wait for Pods to be ready
echo "⏳ Waiting for Pods to be ready..."
kubectl wait --for=condition=ready pod -l app=my-app --timeout=90s

# Retrieve service URL
SERVICE_URL=$(minikube service my-app-service --url)
echo "🚀 App available at: $SERVICE_URL"

# Ensure monitoring namespace exists
kubectl get namespace monitoring &>/dev/null || kubectl create namespace monitoring

# Deploy Monitoring (Prometheus & Grafana)
echo "📈 Deploying Monitoring Tools..."
kubectl apply -f monitoring/prometheus-deployment.yaml -n monitoring
kubectl apply -f monitoring/grafana-deployment.yaml -n monitoring

# Wait for monitoring services
echo "⏳ Waiting for Prometheus & Grafana..."
kubectl wait --for=condition=ready pod -l app=prometheus -n monitoring --timeout=90s
kubectl wait --for=condition=ready pod -l app=grafana -n monitoring --timeout=90s

# Port forwarding for monitoring
echo "🔗 Setting up port-forwarding..."
kubectl port-forward service/prometheus-service 9090:9090 -n monitoring > /dev/null 2>&1 &
kubectl port-forward service/grafana-service 3000:3000 -n monitoring > /dev/null 2>&1 &

# Final output
echo "🎯 Deployment complete!"
echo "📊 Prometheus: http://localhost:9090"
echo "📈 Grafana: http://localhost:3000"
echo "🚀 App: $SERVICE_URL"

#chmod +x deploy.sh
#./deploy.sh