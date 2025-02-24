# LEVERAGING DOCKER AND KUBERNETES FOR A MULTI-CLOUD STRATEGY

This project demonstrates a multi-cloud deployment strategy using **Docker** and **Kubernetes** for containerization and orchestration. It's developed on **GitHub Codespaces** and **Gitpod**, avoiding the need for AWS, GCP, or any paid cloud services.

🚀 Features
Containerization: Uses Docker to containerize the application.
Orchestration: Kubernetes for deploying, managing, and scaling applications.
Multi-Cloud Ready: Ensures the app runs across multiple clusters without vendor lock-in.
Monitoring: Integrated Prometheus and Grafana for real-time metrics and visualization.
Service Mesh: Uses Istio for secure service-to-service communication.
Infrastructure as Code: Managed with Terraform

📂 Project Structure
─ app                        # Python Application
│   ├── app.py                 # Main application file
│   └── requirements.txt       # Python dependencies
│
├── docker                     # Docker-related files
│   ├── docker-compose.yml     # Docker Compose configuration
│   └── Dockerfile             # Dockerfile for containerization
│
├── istio-1.24.3              # Istio setup
│   ├── bin                    # Istio binaries
│   ├── manifests              # Kubernetes manifests for Istio
│   ├── samples                # Example configurations
│   └── tools                  # Utility tools for Istio
│
├── Kubernetes                 # Kubernetes manifests
│   ├── deployment.yaml        # Deployment configuration
│   ├── service.yaml           # Service definition
│   └── single-deployment.yaml # Alternative deployment config
│
├── monitoring                 # Monitoring tools
│   ├── grafana-deployment.yaml# Grafana deployment file
│   ├── prometheus-deployment.yaml # Prometheus deployment file
│   └── prometheus-rbac.yaml   # RBAC settings for Prometheus
│
├── my-app                     # Helm Chart for Kubernetes deployment
│   ├── Chart.yaml             # Chart metadata
│   ├── templates              # Kubernetes resource templates
│   └── values.yaml            # Default configuration values
│
├── terraform                  # Terraform configuration
│   ├── main.tf                # Main Terraform configuration
│   ├── outputs.tf             # Output values
│   ├── variables.tf           # Input variables
│
├── kind-config.yaml           # Kind (Kubernetes in Docker) configuration
├── README.md                  # Project documentation
└── LICENSE.txt                # License information

### ⚙️ **Tools & Technologies**
- **Docker**: Containerization
- **Kubernetes**: Cluster orchestration
- **Terraform**: Infrastructure as Code (IaC)
- **Prometheus & Grafana**: Monitoring and visualization
- **Istio**: Service mesh for traffic management

⚙️ Setup Instructions

1️⃣ Clone the Repository

git clone https://github.com/kvyhg/DevOps_MultiCloud.git
cd DevOps_MultiCloud

2️⃣ Install Dependencies (if needed)

pip install -r app/requirements.txt

3️⃣ Build Docker Containers

cd docker
docker build -t devops-multicloud-app .

4️⃣ Set Up Kubernetes Cluster with Kind

kind create cluster --config kind-config.yaml

5️⃣ Deploy App on Kubernetes

kubectl apply -f Kubernetes/

6️⃣ Set Up Istio Service Mesh

cd istio-1.24.3/bin
./istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

7️⃣ Apply Monitoring Tools

kubectl apply -f monitoring/

8️⃣ Port Forwarding Commands

Access services locally:

kubectl port-forward svc/devops-multicloud-app 8080:80
kubectl port-forward svc/grafana 3000:3000
kubectl port-forward svc/prometheus 9090:9090

9️⃣ Terraform Initialization (Optional for Infrastructure)

cd terraform
terraform init
terraform apply

🔍 Monitoring Dashboards

Grafana: http://localhost:3000
Prometheus: http://localhost:9090

Default login for Grafana:
Username: admin
Password: admin

📜 License
This project is licensed under the MIT License. See LICENSE.txt for more information.
