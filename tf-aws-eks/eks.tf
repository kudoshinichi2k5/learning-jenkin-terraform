# Ref - https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.30"
  cluster_endpoint_public_access  = true

  vpc_id = module.vpc.vpc_id
  
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.small"]
    }
  }

  manage_aws_auth_configmap = true

  # Danh sách user được phép truy cập Cluster
  aws_auth_users = [
    {
      # Thay đúng ARN user của bạn (tôi lấy từ log cũ của bạn)
      userarn  = "arn:aws:iam::306989527393:user/kienle" 
      username = "kienle"
      groups   = ["system:masters"] # Cấp quyền Admin cao nhất
    }
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}