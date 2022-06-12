# Delivery

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/delivery.yaml
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/deploy-app.yaml
```

Deliverable (counterpart to Workload)
```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/deliverable.yaml
```

```terminal:execute
command: ytt --ignore-unknown-comments -f app-operator/deliverable.yaml -f values.yaml | yq
```

```terminal:execute
command: kapp deploy --yes -a example-del -f <(ytt --ignore-unknown-comments -f ./app-operator -f values.yaml)
```

```terminal:execute
command: kubectl tree deliverable gitops
```

```terminal:execute
command: kubectl get deployment --selector serving.knative.dev/service=hello-world
```

```terminal:execute
command: curl http://hello-world-{{ session_namespace }}.{{ ingress_domain }}
```
