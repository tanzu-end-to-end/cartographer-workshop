#!/bin/bash
set -x
set +e

# Pre-install in cluster:
#kapp deploy --yes -a git-serve -f https://github.com/cirocosta/git-serve/releases/latest/download/git-serve.yaml

kubectl create secret generic learningcenter-git-credentials \
  --from-literal=username=$SESSION_NAMESPACE \
  --from-literal=password=$SESSION_NAMESPACE

cat <<'EOF' | kubectl create -f -
apiVersion: ops.tips/v1alpha1
kind: GitServer
metadata:
  name: git
spec:
  image: cirocosta/git-serve
  http:
    auth:
      username:
        valueFrom:
          secretKeyRef:
            name: learningcenter-git-credentials
            key: username
      password:
        valueFrom:
          secretKeyRef:
            name: learningcenter-git-credentials
            key: password
EOF