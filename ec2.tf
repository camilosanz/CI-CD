module "ec2_private_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  count   = 1

  depends_on = [
    module.vpc
  ]

  name = "cavs-cd-private-instance-${count.index}"

  ami                    = "ami-0b0dcb5067f052a63"
  instance_type          = "t2.micro"
  key_name               = var.generated_key_name
  monitoring             = false
  vpc_security_group_ids = ["${module.service_sg.security_group_id}"]
  subnet_id              = module.vpc.private_subnets[count.index]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_public_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  count   = 1

  depends_on = [
    module.vpc
  ]

  name = "cavs-cd-public-instance-${count.index}"

  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = var.generated_key_name
  monitoring                  = false
  vpc_security_group_ids      = ["${module.service_sg.security_group_id}"]
  subnet_id                   = module.vpc.public_subnets[count.index]
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}