# Commands

## Default foreground mode
- Podman run starts the process in the container and attaches the console to the process's standard input, output, and error. This is the default when -d is not specified. 
- podman run

```
# Build a kebernetes manifest
podman generate kube <pod_name>
podman generate kube <pod_name> >> file_name.yaml
podman generate kube <pod_name> --filename new_specification.yaml
# generate a service specification from a pod
podman generate kube <pod_name> --service --filename new_specification.yaml


# create a pod
# in your local podman instance
podman play kube file_name.yaml


# nginx
podman create --name my
```

## Kubernetes, k8s
- examples, use case, demo,  https://istio.io/latest/docs/examples/bookinfo/
- github, DigitalOcean, kubernetes sample apps https://github.com/digitalocean/kubernetes-sample-apps?tab=readme-ov-file
- Kubernetes github, https://github.com/kubernetes/examples?tab=readme-ov-file

```
# kubectl
# Get Your Kubernetes Configuration:
doctl k8s cluster kubeconfig save <cluster-name>
# Step 3: Verify kubectl Configuration
kubectl cluster-info

# after run
podman generate kube <pod_name> --service --filename new_specification.yaml

# auto scaling, auto healing
# create your deployment in your kubernetes cluster
# kubectl apply -f example-deployment.yaml

# run the pod in kubernetes
# kubectl apply -f new_specification.yaml
kubectl create -f new_specification.yaml

kubectl get pods
kubectl get pods -A
kubectl get pods -o wide
# watch
kubectl get pods -w

# delete
kubectl delete pod <pod-name>

# debugs, logs
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

## k8s, deploy
```
# after create your deployment
kubectl get deploy
kubectl get pods
# replica set, rs
kubectl get rs


kubectl delete deploy <deploy-name>

kubectl get all
kubectl get all -A

# services, get external ip
kubectl get service

```