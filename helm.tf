data "aws_region" "current" {}

# https://github.com/kubernetes/autoscaler
# https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler
resource "helm_release" "autoscaler" {
  name        = "autoscaler"
  repository  = "https://kubernetes.github.io/autoscaler"
  chart       = "cluster-autoscaler"
  version     = "9.4.0"
  max_history = 10
  namespace   = var.namespace

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  values = [
    yamlencode({
      nodeSelector      = var.node_selector,
      autoscalingGroups = var.groups,
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
