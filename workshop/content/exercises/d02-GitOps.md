# Delivery

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/delivery.yaml
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/deploy-app.yaml
```

Deliverable (counterpart to Workload)
```editor:insert-lines-before-line
file: /home/eduk8s/exercises/deliverable.yaml
line: 1
text: |-
    apiVersion: carto.run/v1alpha1
    kind: Deliverable
    metadata:
      name: hello-world
      labels:
        app.tanzu.vmware.com/workload-type: deliver-{{session_namespace}}
    spec:
      serviceAccountName: default
      source:
        git:
          url: http://{{git_host}}:{{git_port}}/hello-world-ops.git
          ref:
            branch: main
```

```terminal:execute
command: kapp deploy --yes -a example-del -f <(ytt --ignore-unknown-comments -f ./app-operator -f values.yaml)
```

```terminal:execute
command: kubectl apply -f /home/eduk8s/exercises/deliverable.yaml
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
