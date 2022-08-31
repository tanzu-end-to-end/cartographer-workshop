#!/bin/bash
set -x
set +e

function replace_env_vars() {
  temp_filename = /tmp/$(basename $1)
  envsubst < $1 > $temp_filename && mv $temp_filename $1
}

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'

export SOURCE_REFERENCE="\${NEW_SOURCE}"
for file in examples/basic-delivery/app-operator/*.yaml examples/gitwriter-sc/app-operator/*.yaml; do 
  replace_env_vars $file 
done

#kubectl apply -f exercises/examples/gitwriter-sc/app-operator/config-service.yaml
#kubectl apply -f exercises/examples/gitwriter-sc/app-operator/git-writer-task.yaml
#kubectl apply -f exercises/examples/gitwriter-sc/app-operator/runtemplate-tekton-gitwriter.yaml
#kubectl apply -f exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml
kubectl patch clustertemplate $SESSION_NAMESPACE-git-writer --type=json -p="[{'op': 'replace', 'path': '/spec/params/0/default', 'value': 'https://${GITEA_USER}:${GITEA_PASSWORD}@${GITEA_DOMAIN}/${GITEA_USER}/osscon-deliveries.git'}]"

#kubectl apply -f exercises/examples/basic-delivery/app-operator/delivery.yaml
#kubectl apply -f exercises/examples/basic-delivery/app-operator/deploy-app.yaml
#kubectl apply -f exercises/examples/basic-delivery/app-operator/source-git-repository.yaml
