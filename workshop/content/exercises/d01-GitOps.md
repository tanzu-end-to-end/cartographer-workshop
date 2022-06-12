# Git Writer Supply Chain
```terminal:execute
command: |-
kubectl create secret generic git-server \
  --from-literal=username=git-user \
  --from-literal=password=$SESSION_NAMESPACE
```

```terminal:execute
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
```




```terminal:execute
command: kapp deploy --yes -a gitwriter-sc -f <(ytt --ignore-unknown-comments -f ./app-operator  -f values.yaml)
```

```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/supply-chain.yaml
```

ClusterConfigTemplate for providing configuration in-cluster
```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/config-service.yaml
```

Templates for using Tekton to push to git
```terminal:execute
command: tree ~/exercises/examples/gitwriter-sc/app-operator | grep git
```

ClusterConfigTemplate for providing configuration in-cluster
```terminal:execute
command: yq app-operator/config-service.yaml
```

Templates for using Tekton to push to git
```terminal:execute
command: tree app-operator | grep git
```

Developer Perspective: same SC selector => same workload!
```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/supply-chain.yaml
text: web-{{session-namespace}}
```

```terminal:execute
command: kubectl tree workload hello-world
```

```terminal:execute
command: kubectl get configmap hello-world -o yaml
```

```terminal:execute
command: kubectl get configmap hello-world -o yaml | yq '.data.manifest | @base64d' | yq -P
```


Check ops repo
```terminal:execute
command: |-
git clone http://git-server.{{session_namespace}}.svc.cluster.local:80/gitops-test.git && cd gitops-test && git checkout main
tree
yq -P '.' config/manifest.yaml
```
