# Тестовое задание DevOps разработчик

1. [Первичная установка](docs/project_install.md)
1. [Задание](docs/assignment.md)
helm secrets encrypt prod/secrets.yaml
kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=jokerwrld999 --docker-password=$CR_PAT --docker-email=ifalaleev49@gmail.com -n stage

helm secrets install python-webapp deploy --values deploy/values.yaml -f deploy/values/stage/values.yaml -f deploy/values/stage/secrets.yaml -n stage
helm secrets upgrade python-webapp deploy --values deploy/values.yaml -f deploy/values/stage/values.yaml -f deploy/values/stage/secrets.yaml -n stage

helm uninstall python-webapp -n stage