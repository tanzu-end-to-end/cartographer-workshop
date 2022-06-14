#!/bin/bash
set -x
set +e

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'

envsubst < intro/01_manual/image.yaml > image-tmp.yaml && mv image-tmp.yaml intro/01_manual/image.yaml
