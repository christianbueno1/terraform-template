# notes
- take care of the python version
- Terraform version 1.9.1
- aws provider version 5.57
- random provider version 3.6
- archive provider version 2.4

# Steps
```
sudo dnf install awscli2
aws --version

# isntall terraform, official repository
terraform -version

# region South America
# sao paulo
sa-east-1

# terraform
# initialize terraform
terraform init

# plan deployment
# show AMI id, ec2 instance details
terraform plan

# apply changes
# provisions
terraform apply

# delete, destroy
terraform destroy

```

# Resources
- aws_iam_role

# AMI
- amazon linux 2023, check id on console gui
- t2.micro, 1vCPU, 1GiB, free tier

# Accessing the EC2 instance
```
ssh -i /path/to/mykeypair.pem ec2-user@<INSTANCE_PUBLIC_IP>

```

# AWS CLI
```
# key pairs
aws ec2 describe-key-pairs --key-names mykeypair

```

# Check your public IP Address
```
curl ifconfig.me

# update your Security Group Rule
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["203.0.113.25/32"] # Replace with your actual IP
}

# Apply the updated configuration
terraform init       # Ensure plugins are installed
terraform plan       # Preview the changes
terraform apply      # Apply the changes to AWS

```