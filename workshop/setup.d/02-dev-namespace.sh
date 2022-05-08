#!/bin/bash
set -x
set +e

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'
