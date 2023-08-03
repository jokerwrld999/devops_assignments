# Тестовое задание DevOps разработчик

1. [Первичная установка](docs/project_install.md)
1. [Задание](docs/assignment.md)
helm secrets encrypt prod/secrets.yaml

k create namespace dev
k create namespace stage
k create namespace prod

export CR_PAT=

kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=ifalaleev49@gmail.com -n dev
kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=ifalaleev49@gmail.com -n stage
kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=ifalaleev49@gmail.com -n prod

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.3/cert-manager.yaml

helm secrets install python-webapp-release-dev deploy --values deploy/values.yaml -f deploy/values/dev/values.yaml -f deploy/values/dev/secrets.yaml -n dev --create-namespace
helm secrets install python-webapp-release-stage deploy --values deploy/values.yaml -f deploy/values/stage/values.yaml -f deploy/values/stage/secrets.yaml -n stage --create-namespace
helm secrets install python-webapp-release-prod deploy --values deploy/values.yaml -f deploy/values/prod/values.yaml -f deploy/values/prod/secrets.yaml -n prod --create-namespace

helm secrets upgrade python-webapp-release-dev deploy --values deploy/values.yaml -f deploy/values/dev/values.yaml -f deploy/values/dev/secrets.yaml -n dev
helm secrets upgrade python-webapp-release-stage deploy --values deploy/values.yaml -f deploy/values/stage/values.yaml -f deploy/values/stage/secrets.yaml -n stage
helm secrets upgrade python-webapp-release-prod deploy --values deploy/values.yaml -f deploy/values/prod/values.yaml -f deploy/values/prod/secrets.yaml -n prod

helm secrets upgrade python-webapp-release-stage deploy --values deploy/values.yaml -f deploy/values/stage/values.yaml -f deploy/values/stage/secrets.yaml -n stage

helm uninstall python-webapp-release-dev -n dev
helm uninstall python-webapp-release-stage -n stage
helm uninstall python-webapp-release-prod -n prod


http://127.0.0.1:9999/openapi.json
http://127.0.0.1:9999/secret

http://127.0.0.1:9999/healthcheck
helm ls --all-namespaces


curl -H "Host:  dev.jokerwrld.com" http://$(minikube ip)/
curl -H "Host: stage.jokerwrld.com" http://$(minikube ip)/
curl -H "Host:  prod.jokerwrld.com" http://$(minikube ip)/