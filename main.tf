data "aws_vpc" "default_vpc" {
  default = true
}

#Create security group for EC2 server
### Security Group Module
module "service_sg" {
  source  = "./sg"
  appName = "minikube"
  vpc_id  = data.aws_vpc.default_vpc.id
}

# Terraform module Block to create the iam instance profile
module "iam_instance_profile" {
  source                = "./iam"
  instance_profile_name = "instance-profile-devops"
  iam_policy_name       = "devops-policy"
  role_name             = "role_name"
}

# Terraform module Block to create EC2 Server
module "ec2" {
  source           = "./ec2"
  ec2_name         = "minikube"
  key_name         = "isildur"
  ami              = "ami-080e1f13689e07408"
  instance_type    = "t2.medium"
  vpc_sg           = module.service_sg.service_sg_id
  instance_profile = module.iam_instance_profile.instance_profile
}

data "aws_caller_identity" "current" {}