# 🌍 AWS Provider
provider "aws" {
  region = "us-east-1"
}

# ☁️ Google Cloud Provider
provider "google" {
  project = "myproject123s"
  region  = "us-central1"
}

# ☁️ Azure Provider
provider "azurerm" {
  features = {}
}

# 🌐 AWS EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "multi-cloud-cluster"
  cluster_version = "1.25"
  vpc_subnet_ids = ["subnet-abc123", "subnet-def456"]
}

# 🌐 GCP GKE Cluster
module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google"
  project_id = "myproject123"
  region     = "us-central1"
  name       = "multi-cloud-cluster"
}

# 🌐 Azure AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "multi-cloud-cluster"
  location            = "East US"
  resource_group_name = "myResourceGroup"
  dns_prefix          = "multi-cloud-aks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
  }
}
