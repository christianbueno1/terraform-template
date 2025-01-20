# Information
- Hashicorp Vault https://www.youtube.com/watch?v=wfGzOduNoas
- in provider use a profile key
- install Vault
```
# default user profile
aws configure list
# specific profile
aws configure list --profile <user>

aws iam list-users

aws iam list-access-keys --user <user>
aws iam list-access-keys --user terraform-user

# create access key
aws iam create-access-key --user-name <user>
aws iam create-access-key --user-name terraform-user

aws configure --profile <user>
aws configure --profile terraform-user
# enter acces key
# secret key
# region
# default output


```