#!/bin/bash

# Navigate to the app directory
cd app

# Build the Docker image
echo "🐳 Building Flask app Docker image..."
docker build -t flask-app .

# Stop and remove any running container with the same name
echo "🛑 Stopping any existing Flask container..."
docker stop flask-container 2>/dev/null
docker rm flask-container 2>/dev/null

# Run the Flask container on port 5000
echo "🚀 Running Flask app container..."
docker run -d -p 5000:5000 --name flask-container flask-app

echo "✅ Flask app deployed! Access it at http://localhost:5000"

# Move back to the root directory
cd ..

# Check if Minikube is installed
echo "🔍 Checking if Minikube is installed..."
if ! command -v minikube &> /dev/null
then
    echo "❌ Minikube not found! Please install Minikube first."
    exit 1
fi

# Start Minikube
echo "🚀 Starting Minikube..."
minikube start --driver=docker

# Set up Docker to use Minikube’s daemon
echo "🔧 Configuring Docker to use Minikube..."
eval $(minikube docker-env)

# Build the Docker image for Kubernetes
echo "🐳 Building Docker image for Kubernetes..."
docker build -t my-app:latest ./app

# Deploy application to Kubernetes
echo "📦 Deploying application to Kubernetes..."
kubectl apply -f Kubernetes/deployment.yaml
kubectl apply -f Kubernetes/service.yaml

# Wait for application pods to be ready
echo "⏳ Waiting for application pods to be ready..."
kubectl wait --for=condition=ready pod -l app=my-app --timeout=90s

# Retrieve service URL
echo "🔍 Retrieving service URL..."
SERVICE_URL=$(minikube service my-app-service --url)
echo "🚀 App available at: $SERVICE_URL"

# Set up Istio (if needed)
echo "🚀 Setting up Istio..."
kubectl apply -f istio-1.24.3/manifests

# Deploy monitoring tools
echo "📈 Deploying monitoring tools (Prometheus & Grafana)..."
kubectl apply -f monitoring/prometheus-deployment.yaml
kubectl apply -f monitoring/grafana-deployment.yaml

# Wait for monitoring pods to be ready
echo "⏳ Waiting for monitoring tools to be ready..."
kubectl wait --for=condition=ready pod -l app=prometheus --timeout=90s
kubectl wait --for=condition=ready pod -l app=grafana --timeout=90s

# Free up ports if already in use
echo "🔍 Checking if ports 3000 and 9090 are free..."
sudo lsof -ti :3000 | xargs -r sudo kill -9
sudo lsof -ti :9090 | xargs -r sudo kill -9
echo "✅ Ports cleared!"

# Forward ports for Prometheus and Grafana
echo "🔗 Forwarding ports for Prometheus and Grafana..."
kubectl port-forward service/prometheus-service 9090:9090 > /dev/null 2>&1 &
kubectl port-forward service/grafana-service 3000:3000 > /dev/null 2>&1 &

# Final output
echo "🎯 Deployment complete!"
echo "📊 Prometheus: http://localhost:9090"
echo "📈 Grafana: http://localhost:3000"
echo "🚀 App: $SERVICE_URL"
