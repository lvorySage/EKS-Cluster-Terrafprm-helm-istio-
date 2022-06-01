output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}


output "region" {
  description = "AWS region."
  value       = var.region
}

output "eks_auth_command" {
  description = "IAM Authenticator command"
  value       = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_id}"

}


output "cluster_name" {
  description = "Cluster Name."
  value       = module.eks.cluster_id
}

# output "kubeconfig_export" {
#   description = "Accessing cluster"
#   value       = "export KUBECONFIG=${module.eks.kubeconfig_filename}"
# }



