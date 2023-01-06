module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "cavs-cd-assignment-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.1.0.0/24"]
  public_subnets  = ["10.1.1.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "cavs-cd-assignment-sg"
  description = "Security group for peer connection"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp", "https-443-tcp"]
}