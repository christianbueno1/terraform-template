## 2. Use Environment Variables

Sensitive values like access keys, key pair names, or CIDR blocks can also be stored as environment variables. Terraform automatically picks up variables prefixed with TF_VAR_.

Example:
```
# Terraform
export TF_VAR_key_pair_name="mykeypair"
export TF_VAR_aws_region="my-region"
#export TF_VAR_allowed_ssh_cidr="203.0.113.25/32"
```
In your Terraform file, simply reference these variables:
```
Copy code
key_name = var.key_pair_name
```

## 3. Use .gitignore for Private Files

Ensure sensitive files, such as terraform.tfvars, are excluded from version control by adding them to your .gitignore file:
```
terraform.tfvars
*.pem
```
This prevents sensitive data from being accidentally committed to repositories.

## AWS
```
# list EC2
aws ec2 describe-instance-status --instance-ids
aws ec2 describe-instance-status --instance-ids --query "InstanceStatuses[].InstanceId" | tee

# decribe
aws ec2 describe-instances --instance-ids
aws ec2 describe-instances --instance-ids <instance-id>
aws ec2 describe-instances --instance-ids i-0f24cf3a355ae43a1
aws ec2 describe-instances --instance-ids i-0f24cf3a355ae43a1 | tee
#
aws ec2 describe-instances --instance-ids i-0f24cf3a355ae43a1 --query "Reservations[*].Instances[*].PublicIpAddress" --output text | tee
#
aws ec2 describe-instances --instance-ids i-049b1fbabe5ab4ae6 --query "Reservations[*].Instances[*].State.Name" --output text | tee
#
aws ec2 describe-instances --instance-ids i-049b1fbabe5ab4ae6 --query "Reservations[*].Instances[*].Tags" --output json | tee
#
# --output text
aws ec2 describe-instances --output text | tee
#
aws ec2 describe-instances \
--instance-ids i-0f24cf3a355ae43a1 \
--query "Reservations[*].Instances[*].PublicDnsName" \
--output text | tee
#
aws ec2 describe-instances \
--instance-ids i-0f24cf3a355ae43a1 \
--query "Reservations[].Instances[].{PublicIp:PublicIpAddress, host:PublicDnsName}" \
--output text | tee
#
# vertically
aws ec2 describe-instances \
--instance-ids i-0f24cf3a355ae43a1 \
--query "Reservations[].Instances[].{PublicIp:PublicIpAddress, Host:PublicDnsName}" \
--output text | awk 'BEGIN {OFS=": "} {print "PublicIp", $1; print "Host", $2}' | tee



# user
ec2-user
#
ssh -i "chris@f40.pem" ec2-user@ec2-52-91-223-134.compute-1.amazonaws.com
#
# default pem, private-key file
kitten ssh ec2-user@ec2-54-145-165-246.compute-1.amazonaws.com
ssh ec2-user@ec2-54-145-165-246.compute-1.amazonaws.com

# local
ssh-keygen -l -E sha256 -f ~/.ssh/known_hosts
```

## web exmaple
- https://www.tooplate.com/view/2135-mini-finance
