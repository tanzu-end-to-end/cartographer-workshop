#!/bin/bash
set -x
set +e

replace_env_vars () {
  temp_filename=/tmp/$(basename $1)
  envsubst < $1 > $temp_filename && mv $temp_filename $1
}

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'

export SOURCE_REFERENCE="\${NEW_SOURCE}"
for file in exercises/examples/basic-delivery/app-operator/*.yaml exercises/examples/gitwriter-sc/app-operator/*.yaml; do 
  replace_env_vars $file 
done

kubectl patch clustertemplate $SESSION_NAMESPACE-git-writer --type=json -p="[{'op': 'replace', 'path': '/spec/params/0/default', 'value': 'https://${GITEA_USER}:${GITEA_PASSWORD}@${GITEA_DOMAIN}/${GITEA_USER}/osscon-deliveries.git'}]"
