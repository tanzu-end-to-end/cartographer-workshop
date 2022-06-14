#!/bin/bash
set -x
set +e

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'

export SOURCE_REFERENCE="\${NEW_SOURCE}"
envsubst < exercises/intro/01_manual/image.yaml > /tmp/image.yaml && mv /tmp/image.yaml exercises/intro/01_manual/image.yaml
