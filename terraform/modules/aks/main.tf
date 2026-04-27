# Devopstrio AI Landing Zone: High-Performance GPU AKS Module
# Purpose: LLM Inference & Training Platform

resource "azurerm_kubernetes_cluster" "ai_aks" {
  name                = "aks-ai-workloads-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "ai-plat"

  # System Pool (Management)
  default_node_pool {
    name                = "system"
    node_count          = 2
    vm_size             = "Standard_DS2_v2"
    vnet_subnet_id      = var.aks_subnet_id
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    load_balancer_sku  = "standard"
  }
}

# GPU Nodepool (Inference Tier)
resource "azurerm_kubernetes_cluster_node_pool" "gpu_pool" {
  name                  = "gpuinference"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.ai_aks.id
  vm_size               = "Standard_NC6s_v3" # NVIDIA Tesla V100
  node_count            = 1
  enable_auto_scaling   = true
  min_count             = 1
  max_count             = 10
  vnet_subnet_id        = var.aks_subnet_id

  node_labels = {
    "workload-type" = "ai-inference"
    "accelerator"   = "gpu"
  }

  node_taints = ["sku=gpu:NoSchedule"]
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.ai_aks.id
}
