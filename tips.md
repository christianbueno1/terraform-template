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