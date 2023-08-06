#!/bin/bash

echo "Run Cleanup Script"

kubectl get crd issuers.cert-manager.io > /dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "Run Cleanup commands"
    kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.3/cert-manager.yaml > /dev/null 2>&1
    minikube addons disable ingress > /dev/null 2>&1
fi