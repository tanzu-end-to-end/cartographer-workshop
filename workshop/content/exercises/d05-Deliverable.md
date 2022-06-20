Review ClusterDelivery
```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/delivery.yaml
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/source-git-repository.yaml
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/deploy-app.yaml
```

Author Deliverable
```editor:insert-lines-before-line
file: /home/eduk8s/exercises/deliverable.yaml
line: 1
text: |-
    apiVersion: carto.run/v1alpha1
    kind: Deliverable
    metadata:
      name: hello-world-deployment
      labels:
        app.tanzu.vmware.com/deliverable-type:
    spec:
      serviceAccountName: default
      source:
        git:
          ref:
            branch:
          url:
```

```editor:select-matching-text
file:  /home/eduk8s/exercises/deliverable.yaml
text: "app.tanzu.vmware.com/deliverable-type:"
```

```editor:replace-text-selection
file:  /home/eduk8s/exercises/deliverable.yaml
text: "app.tanzu.vmware.com/deliverable-type: osscon"
```

```editor:select-matching-text
file:  /home/eduk8s/exercises/deliverable.yaml
text: "git:"
before: 0
after: 3
```

```editor:replace-text-selection
file:  /home/eduk8s/exercises/deliverable.yaml
text: |2
      git:
        ref:
          branch: {{session_namespace}}-hello-world
        url: https://gitea.{{ingress_domain}}/gitea_admin/osscon-deliveries
```

```terminal:execute
command: kubectl apply -f ~/exercises/deliverable.yaml
```

```terminal:execute
command: kubectl get gitrepository hello-world-deployment
```

```terminal:execute
command: kn service list
```

```terminal:execute
command: kubectl get deliverable
```
