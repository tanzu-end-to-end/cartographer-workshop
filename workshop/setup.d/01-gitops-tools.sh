#!/bin/bash
set -x
set +e

# Pre-install in cluster:
#kapp deploy --yes -a git-serve -f https://github.com/cirocosta/git-serve/releases/latest/download/git-serve.yaml

kubectl create secret generic git-server \
  --from-literal=username=git-user \
  --from-literal=password=$SESSION_NAMESPACE

cat <<'EOF' | kubectl create -f -
apiVersion: ops.tips/v1alpha1
kind: GitServer
metadata:
  name: git-server
spec:
  image: cirocosta/git-serve
  http:
    auth:
      username:
        valueFrom:
          secretKeyRef:
            name: git-server
            key: username
      password:
        valueFrom:
          secretKeyRef:
            name: git-server
            key: password
EOF