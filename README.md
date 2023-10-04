# Тестовое задание DevOps разработчик

1. [Первичная установка](docs/project_install.md)
2. [Задание](docs/assignment.md)

# Minikube installation
Installation: https://minikube.sigs.k8s.io/docs/start/
```
minikube config set driver docker
minikube start // stop
minikube status
```

# Kubectl Installation/Configuration
Installation: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

```
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

cat ~/.kube/config  // kubectl config view
alias k='kubectl'
```

# Helm Installation/Configuration
Installation: https://helm.sh/docs/intro/install/
Cheat Sheet: https://helm.sh/docs/intro/cheatsheet/

```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

# Plugins Installation
```
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/aslafy-z/helm-git
helm plugin install https://github.com/jkroepke/helm-secrets
```

# Secrets Encryption
```
helm secrets encrypt prod/secrets.yaml
```
# Namespace Creation
```
kubectl create namespace dev
kubectl create namespace stage
kubectl create namespace prod
```

# Github Registry Login
```
export CR_PAT=

kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=example@gmail.com -n dev
kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=example@gmail.com -n stage
kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=example@gmail.com -n prod
```

# Helmfile Deployment
Installation: https://github.com/helmfile/helmfile/releases

## Development Environment
```
helmfile --file helmfile.yaml -e dev apply --interactive
helmfile --file helmfile.yaml -e dev destroy
```

## Staging Environment
```
helmfile --file helmfile.yaml -e stage apply --interactive
helmfile --file helmfile.yaml -e stage destroy
```

## Production Environment
```
helmfile --file helmfile.yaml -e prod apply --interactive
helmfile --file helmfile.yaml -e prod destroy
```

# Debug/Healthcheck
Service_IP/openapi.json
Service_IP/secret
Service_IP/healthcheck

# Access Commands
```
curl -H "Host: dev.jokerwrld.com" http://$(minikube ip)/
curl -H "Host: stage.jokerwrld.com" -k https://$(minikube ip)/
curl -H "Host: prod.jokerwrld.com" -k https://$(minikube ip)/
```
