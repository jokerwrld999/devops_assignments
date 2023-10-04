# DevOps Developer Test Task

You have an application called "hello-world" written in Python with FastAPI, which returns the string "Hello World `<environment>`!", where `<environment>` may vary based on the context or settings.

## Tasks

1. Create a public repository on GitHub or its alternatives, copy the entire project from the `devops` directory, and continue working in it.

2. Wrap this application in a Dockerfile, in which
   1. Dependencies will be installed via poetry ([installation via poetry](project_install.md))
   2. The application will be launched via the `gunicorn` web server ([gunicorn.sh](../gunicorn.sh))

3. Write a Helm chart in which
   1. [Configmap](../deploy/chart/templates/configmap.yaml) for environment variables ([ENVIRONMENT](../app/config.py))
      1. The variable `ENVIRONMENT` should have values: `dev`, `stage`, `prod` depending on the environment.
   2. [Secret](../deploy/chart/templates/secret.yaml) for secret environment variables ([ENVIRONMENT_FROM_SECRET](../app/config.py))
      1. Secrets should be encrypted using any method available for k8s (e.g., `helm-secrets`)
      2. The secret `ENVIRONMENT_FROM_SECRET` should have values: `secret_dev`, `secret_stage`, `secret_prod` depending on the environment.
   3. [Deployment](../deploy/chart/templates/deployment.yaml), which will
      1. Start 2 replicas of the application
      2. Work on port `8000`
      3. Inject `ConfigMap` and `Secret` into the container
      4. Have readiness and liveness probes on the `/healthcheck` endpoint
   4. [Service](../deploy/chart/templates/service.yaml) of type ClusterIP
   5. [Ingress](../deploy/chart/templates/ingress.yaml) for the nginx server, which should be configured for hosts
      1. dev - localhost
      2. stage - farforstaging.ru
      3. prod - farfor.ru
   6. [CertManager](../deploy/chart/templates/certmanager.yaml) in which
      1. `Issuer` for issuing acme-letsencrypt certificates through `http01.ingress`
      2. `Certificate` - the corresponding certificate associated with `Issuer` for environment domains `stage` and `prod`
      - P.S. Naturally, there is no need to attempt to issue certificates, just write manifests
   7. [HorizontalPodAutoscaler](../deploy/chart/templates/hpa.yaml), which will
      1. Scale replicas from 2 to 4
      2. The scaling trigger will be CPU or memory usage at 80%
   8. [_helpers.tpl](../deploy/chart/templates/_helpers.tpl), where you define templates for
      1. `selectorLabels`, where you define selector labels `app` and `release`
      2. `labels` including `selectorLabels`, where you define common labels `chart` and `version` + `selectorLabels`
      and use templates in the appropriate places in the chart
   9. [helmfile](../deploy/helmfile.yaml) for three (`dev`, `stage`, `prod`) environments
   10. Use common variables to the maximum and reuse environment variables as needed
   11. Write a step-by-step guide for building the application and running it through minikube.

## Result
The application should:
   1. Be built via Dockerfile
   2. Start via minikube
   3. Work at http://0.0.0.0:8000/ and display the value of the `ENVIRONMENT` variable in the response
   4. At http://0.0.0.0:8000/docs, display the value of the `ENVIRONMENT_FROM_SECRET` variable in the page header

Configuration files are prepared for all environments.
