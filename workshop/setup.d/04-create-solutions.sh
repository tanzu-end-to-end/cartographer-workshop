#!/bin/bash
set -x
set +e

envsubst < exercises/solutions/source.yaml > /tmp/source.yaml && mv /tmp/source.yaml exercises/solutions/source.yaml
envsubst < exercises/solutions/image.yaml > /tmp/image.yaml && mv /tmp/image.yaml exercises/solutions/image.yaml
envsubst < exercises/solutions/app-deploy.yaml > /tmp/app-deploy.yaml && mv /tmp/app-deploy.yaml exercises/solutions/app-deploy.yaml
envsubst < exercises/solutions/supply-chain.yaml > /tmp/supply-chain.yaml && mv /tmp/supply-chain.yaml exercises/solutions/supply-chain.yaml
envsubst < exercises/solutions/workload.yaml > /tmp/workload.yaml && mv /tmp/workload.yaml exercises/solutions/workload.yaml