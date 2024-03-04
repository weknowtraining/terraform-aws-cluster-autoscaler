variable "namespace" {
  description = "The namespace to install everything into"
}

variable "groups" {
  type        = list(map(string))
  default     = []
  description = "The ASGs we should manage"
}

variable "cluster_name" {
  type        = string
  description = "The EKS cluster name (module.eks.cluster_name)"
}

variable "cluster_oidc_issuer_url" {
  description = "The cluster_oidc_issuer_url for the EKS cluster (module.eks.cluster_oidc_issuer_url)"
}

variable "oidc_provider_arn" {
  description = "The oidc_provider_arn for the EKS cluster (module.eks.oidc_provider_arn)"
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

variable "chart_version" {
  type        = string
  description = "The version of the helm chart to install"
}

variable "image_version" {
  type        = string
  description = "Version of the autoscaler to run"
}
