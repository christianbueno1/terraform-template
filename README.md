## notes
- take care of the python version
- Terraform version 1.9.1
- aws provider version 5.57
- random provider version 3.6
- archive provider version 2.4

## Steps
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
#
terraform validate

# plan deployment
# show AMI id, ec2 instance details
# terraform plan -var="public_key_path=/home/chris/.ssh/id_ed25519.pub"
terraform plan

# apply changes
# provisions
terraform apply

# delete, destroy
terraform destroy

```

## Resources
- aws_iam_role

## AMI
- amazon linux 2023, check id on console gui
- t2.micro, 1vCPU, 1GiB, free tier

## Accessing the EC2 instance
```
# using kitty terminal
# use word kitten the first time
kitten ssh -i /path/to/mykeypair.pem ec2-user@<INSTANCE_PUBLIC_IP>
#
ssh -i /path/to/mykeypair.pem ec2-user@<INSTANCE_PUBLIC_IP>

```

## AWS CLI
```
# key pairs
aws ec2 describe-key-pairs --key-names mykeypair

```

## Check your public IP Address
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
#terraform fmt
#terraform validate
terraform plan       # Preview the changes
terraform apply      # Apply the changes to AWS


```

## Terraform Debug
```
# run in terminal
#export TF_LOG=TRACE
# export TF_LOG=DEBUG
#export TF_LOG=INFO
export TF_LOG=WARN
# export TF_LOG=ERROR
echo $TF_LOG
# unset
unset TF_LOG

```
## Provide a Value for the Variable
```
# variables.tf
variable "private_key_path" {
  description = "Path to the private key file for SSH access"
  type        = string
}

```
### Using a terraform.tfvars file

Create a file named terraform.tfvars and add the following line:
```
# terraform.tfvars
private_key_path = "/path/to/your/private/key.pem"
```