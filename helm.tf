data "aws_region" "current" {}

# https://github.com/kubernetes/autoscaler
# https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler
resource "helm_release" "autoscaler" {
  name        = "autoscaler"
  repository  = "https://kubernetes.github.io/autoscaler"
  chart       = "cluster-autoscaler"
  version     = var.chart_version
  max_history = 10
  namespace   = var.namespace

  values = [
    yamlencode({
      awsRegion         = data.aws_region.current.name
      nodeSelector      = var.node_selector,
      autoscalingGroups = var.groups,
      image = {
        tag        = var.image_version
        repository = "registry.k8s.io/autoscaling/cluster-autoscaler"
      }
      rbac = {
        serviceAccount = {
          name = var.service_account_name,
          annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
          }
        }
      }
    })
  ]

  depends_on = [aws_iam_role_policy.this]
}
