##### Git Writer Supply Chain

Delete workload
```terminal:execute
command: kubectl delete workload hello-world
```

```terminal:execute
command: kubectl get gitrepository,cnbimage,ksvc 
```

```editor:open-file
file: /home/eduk8s/exercises/examples/gitwriter-sc/app-operator/config-service.yaml
```


Modify Supply Chain
```editor:select-matching-text
file: ~/exercises/supply-chain.yaml
text: "# kapp"
before: 0
after: 7
```

```editor:replace-text-selection
file: ~/exercises/supply-chain.yaml
text: |2
      # ConfigMap
      - name: config-provider
        templateRef:
          kind: ClusterConfigTemplate
          name:  osscon-app-config
        images:
          - resource: image-builder
            name: image
```

```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/template-git-writer.yaml
```

```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/git-writer-task.yaml
```

```editor:append-lines-to-file
file: /home/eduk8s/exercises/supply-chain.yaml
text: |2
      # Tekton/TaskRun
      - name: git-writer
        templateRef:
          kind: ClusterTemplate
          name:  osscon-git-writer
        configs:
          - resource: config-provider
            name: data
```

```terminal:execute
command: kubectl apply -f ~/exercises/supplychain.yaml
```

Re-create workload
```terminal:execute
command: kubectl apply -f ~/exercises/workload.yaml
```

```dashboard:open-url
url: https://gitea.{{ingress_domain}}/gitea_admin/osscon-deliveries/src/branch/{{session_namespace}}-hello-world/config
```

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



