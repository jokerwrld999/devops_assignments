# Тестовое задание DevOps разработчик

1. [Первичная установка](docs/project_install.md)
1. [Задание](docs/assignment.md)
helm secrets install python-webapp deploy --values deploy/chart/values.yaml -f deploy/values/stage/values.yaml -f deploy/values/stage/secrets.yaml -n stage —dry-run —debug