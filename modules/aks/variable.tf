variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster will be deployed"
  type        = string
}

variable "environment" {
  description = "Deployment environment for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "node_vm_size" {
  description = "The size of the Virtual Machines to use for nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "aks_subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed"
  type        = string
}

variable "service_cidr" {
  description = "The CIDR notation IP range from which to assign service cluster IPs"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address within the service CIDR that will be used by cluster service discovery (DNS)"
  type        = string
  default     = "10.0.0.10"
}

variable "docker_bridge_cidr" {
  description = "CIDR notation IP for Docker bridge"
  type        = string
  default     = "172.17.0.1/16"
}
