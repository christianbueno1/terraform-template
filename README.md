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

