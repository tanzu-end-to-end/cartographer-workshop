#!/bin/bash
set -x
set +e

replace_env_vars () {
  temp_filename=/tmp/$(basename $1)
  envsubst < $1 > $temp_filename && mv $temp_filename $1
}

# get user and password from secret, if it was used
if [ "x${GITEA_ADMIN_SECRET}" != "x" ]; then
  echo "Looking up user and password from secret ${GITEA_ADMIN_SECRET}"
  GITEA_USER=$(kubectl get secret $GITEA_ADMIN_SECRET -o jsonpath='{.data.username}' | base64 -d)
  GITEA_PASSWORD=$(kubectl get secret $GITEA_ADMIN_SECRET -o jsonpath='{.data.password}' | base64 -d)
fi

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "learningcenter-registry-credentials"}]}'
kubectl patch serviceaccount default -p '{"secrets": [{"name": "learningcenter-registry-credentials"}]}'

export SOURCE_REFERENCE="\${NEW_SOURCE}"

for file in exercises/manual/image.yaml exercises/examples/basic-delivery/app-operator/*.yaml exercises/examples/gitwriter-sc/app-operator/*.yaml; do 
  replace_env_vars $file 
done

kubectl patch clustertemplate $SESSION_NAMESPACE-git-writer --type=json -p="[{'op': 'replace', 'path': '/spec/params/0/default', 'value': 'https://${GITEA_USER}:${GITEA_PASSWORD}@${GITEA_DOMAIN}/${GITEA_USER}/osscon-deliveries.git'}]"
