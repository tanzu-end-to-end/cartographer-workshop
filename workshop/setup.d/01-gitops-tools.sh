#!/bin/bash
set -x
set +e

# Pre-install in cluster:
#kapp deploy --yes -a git-serve -f https://github.com/cirocosta/git-serve/releases/latest/download/git-serve.yaml

# In each session:
cat <<'EOF' | kubectl create -f -
apiVersion: ops.tips/v1alpha1
kind: GitServer
metadata:
  name: git-server
spec:
  image: cirocosta/git-serve
EOF
