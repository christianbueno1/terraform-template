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

## To enable OpenTofu tab-completion in Zsh:

```bash
tofu init
tofu validate

tofu -install-autocomplete
# Then, restart your terminal or source your Zsh configuration file:
source ~/.zshrc

# To uninstall OpenTofu tab-completion:
tofu -uninstall-autocomplete



cd /home/chris/projects/terraform-template/droplet-do
tofu plan -out plan.tfplan
tofu show -json plan.tfplan | jq '.'   # optional: inspect plan JSON
# apply when ready
tofu apply plan.tfplan
# After apply, add the host to your SSH config with the script we added:
# adds Host do-love with the IP from the OpenTofu output (droplet_ip)
./scripts/add_do_host.sh do-love

# Example usage with a variable file
# Simula lo que va a pasar:
tofu plan -var-file="tofu.tfvars"
# apply changes:
tofu apply -var-file="tofu.tfvars"
# after apply, add the host to your SSH config with the script we added:
./scripts/add_do_host.sh do-love


# 2️⃣ Verificar qué se destruirá
tofu plan -destroy
# 3️⃣ Destruir el droplet
tofu destroy
#
# Destroy the droplet without confirmation prompt
tofu destroy -auto-approve


```

## 1. terraform.auto.tfvars or *.auto.tfvars:
You can create a file named `secrets.auto.tfvars` in the same directory as your Terraform configuration files. This file will be automatically loaded by OpenTofu and can contain sensitive information like your DigitalOcean API token.
```hcl
# secrets.auto.tfvars
do_token = "your-digitalocean-token-here"
```
## 2. Environment-specific variable files:
Ideal for environment-specific veariables, dev, prod, etc.Example
dev.auto.tfvars, prod.auto.tfvars, etc.
## 3. opentofu.tfvars:
Automatic Loading: Like terraform.tfvars, a file named opentofu.tfvars would likely be automatically loaded by OpenTofu.
## Summary and Best Practices:
- **For sensitive data:** Use a custom .tfvars file (e.g., secrets.tfvars) and load it explicitly with -var-file. Crucially, never commit this file to version control in plain text.
- **For environment-specific variables:** Use *.auto.tfvars (e.g., dev.auto.tfvars, prod.auto.tfvars) for automatic loading.
- **For general, non-sensitive variables:** terraform.tfvars (or opentofu.tfvars if using OpenTofu) is appropriate for automatic loading of common variables.


# Cloudflare API Token Permissions
## using curl
```bash

export CLOUDFLARE_API_TOKEN=$(cat ~/Documents/cloudflare-api-token.txt)
export CF_API_TOKEN=$(cat ~/Documents/cloudflare-api-token.txt)

curl "https://api.cloudflare.com/client/v4/user/tokens/verify" \
-H "Authorization: Bearer v2bKIAH9aMgHM4UiDpjLkL6mniYz7Xtzqzhosmf4"

curl "https://api.cloudflare.com/client/v4/user/tokens/verify" \
-H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}" | jq '.'

curl -s -X GET "https://api.cloudflare.com/client/v4/zones" \
     -H "Authorization: Bearer $CF_API_TOKEN" \
     -H "Content-Type: application/json" | jq

ZONE_ID="your_zone_id_here"

curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CF_API_TOKEN" \
     -H "Content-Type: application/json" | jq


# activate Proxied
export DOMAIN="christianbueno.tech"

#
RECORD_NAME="n8nai"
RECORD_ID=$(curl -s -X GET \
  "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$RECORD_NAME.$DOMAIN" \
  -H "Authorization: Bearer $CF_API_TOKEN" \
  -H "Content-Type: application/json" \
  | jq -r '.result[0].id')

echo $RECORD_ID

# proxied to true.
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "Authorization: Bearer $CF_API_TOKEN" \
     -H "Content-Type: application/json" \
     --data "{
        \"type\": \"A\",
        \"name\": \"n8nai.$DOMAIN\",
        \"content\": \"$DROPLET_IP\",
        \"ttl\": 1,
        \"proxied\": true
     }"


# verify
curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
  -H "Authorization: Bearer $CF_API_TOKEN" \
  -H "Content-Type: application/json" | jq


```