variable "namespace" {
  description = "The namespace to install everything into"
}

variable "groups" {
  type        = list(map(string))
  default     = []
  description = "The ASGs we should manage"
}

variable "cluster_id" {
  type        = string
  description = "The EKS cluster ID"
}

variable "cluster_oidc_issuer_url" {
  description = "The cluster_oidc_issuer_url for the EKS cluster"
}

variable "oidc_provider_arn" {
  description = "The oidc_provider_arn for the EKS cluster"
}

variable "service_account_name" {
  default     = "cluster-autoscaler"
  description = "The name of the K8s service account"
}

variable "node_selector" {
  default = {
    # By default, don't run the autoscaler on spot nodes
    "eks.amazonaws.com/capacityType" = "ON_DEMAND"
  }

  description = "Node selector for the autoscaler pods"
}
