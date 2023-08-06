#!/bin/bash

echo "Run Pre-Install Script"

kubectl get crd issuers.cert-manager.io > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "Run Pre-Install commands"
    minikube addons enable ingress > /dev/null 2>&1
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.3/cert-manager.yaml > /dev/null 2>&1
    sleep 15
fi