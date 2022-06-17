#!/bin/bash
set -x
set +e

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'

export SOURCE_REFERENCE="\${NEW_SOURCE}"
envsubst < exercises/manual/image.yaml > /tmp/image.yaml && mv /tmp/image.yaml exercises/manual/image.yaml
envsubst < exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml > /tmp/template-git-writer.yaml && mv /tmp/template-git-writer.yaml exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml

kubectl apply -f exercises/examples/gitwriter-sc/app-operator/config-service.yaml
kubectl apply -f exercises/examples/gitwriter-sc/app-operator/git-writer-task.yaml
kubectl apply -f exercises/examples/gitwriter-sc/app-operator/runtemplate-tekton-gitwriter.yaml
kubectl apply -f exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml

kubectl apply -f exercises/examples/basic-delivery/app-operator/delivery.yaml
kubectl apply -f exercises/examples/basic-delivery/app-operator/deploy-app.yaml
kubectl apply -f exercises/examples/basic-delivery/app-operator/source-git-repository.yaml
