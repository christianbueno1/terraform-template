# Install
```
# cli 
sudo dnf install doctl

# Verify Installation:
doctl version

# Configuring doctl
# Get Your API Token:
# Authenticate doctl:
doctl auth init
# Verify Authentication:
doctl account get

# kubectl
# Get Your Kubernetes Configuration:
doctl k8s cluster kubeconfig save <cluster-name>
# Step 3: Verify kubectl Configuration
kubectl cluster-info



```

# Common Commands
```
# List Droplets:
doctl compute droplet list
# list images
doctl compute image list-distribution --format ID,Distribution,Slug

# Create a New Droplet:
doctl compute droplet create <droplet-name> --region <region-slug> --image <image-slug> --size <size-slug>
doctl compute droplet create fedora41-2 --region nyc3 --image fedora-41-x64 --size s-1vcpu-4gb

# fora container projects, $24/month
doctl compute droplet create fedora41-2 --region nyc3 --image fedora-41-x64 --size s-2vcpu-4gb

# list size of droplet
doctl compute size list

# Delete a Droplet:
doctl compute droplet delete <droplet-id>

# List Kubernetes Clusters:
doctl kubernetes cluster list

# doctl kubernetes options versions
doctl kubernetes options versions

# create reserved ip
doctl compute reserved-ip create
# and assign
doctl compute reserved-ip create --region <region> --droplet-id <droplet-id>
doctl compute reserved-ip create --region nyc3

# assing after
doctl compute reserved-ip-action assign <reserved-ip> <droplet-id>

# list reserved ip
doctl compute reserved-ip list

# Delete a reserved IP
doctl compute reserved-ip delete <reserved-ip>

# Get information about a specific reserved IP
doctl compute reserved-ip get <reserved-ip>

```

