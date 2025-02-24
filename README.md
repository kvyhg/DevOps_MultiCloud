# LEVERAGING DOCKER AND KUBERNETES FOR A MULTI-CLOUD STRATEGY

This project demonstrates a multi-cloud deployment strategy using **Docker** and **Kubernetes** for containerization and orchestration. It's developed on **GitHub Codespaces** and **Gitpod**, avoiding the need for AWS, GCP, or any paid cloud services.

### 🔍 **Key Features**
- **Multi-Cloud Flexibility**: Runs seamlessly across different cloud providers (without vendor lock-in).
- **Containerization**: Uses **Docker** for creating lightweight, portable containers.
- **Orchestration**: Deploys containers across clusters using **Kubernetes**.
- **Monitoring**: Implements **Prometheus** and **Grafana** for real-time monitoring.
- **Service Mesh**: Integrates **Istio** for advanced traffic management and security between services.

### ⚙️ **Tools & Technologies**
- **Docker**: Containerization
- **Kubernetes**: Cluster orchestration
- **Terraform**: Infrastructure as Code (IaC)
- **Prometheus & Grafana**: Monitoring and visualization
- **Istio**: Service mesh for traffic management

### 💻 **Setup Instructions**
1. **Clone the repository:**
   ```bash
   git clone https://github.com/kvyhg/DevOps_MultiCloud.git
   cd DevOps_MultiCloud
   ```

2. **Run on GitHub Codespaces or Gitpod** (No local setup required)

3. **Initialize Terraform:**
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

4. **Deploy Kubernetes resources:**
   ```bash
   kubectl apply -f kubernetes/
   ```

5. **Set up monitoring:**
   ```bash
   kubectl apply -f monitoring/
   ```

### 📊 **Monitoring Dashboard**
Access the **Grafana Dashboard** via the exposed service to monitor app performance and metrics.

### 📝 **License**
This project is open-source under the [MIT License](LICENSE).
