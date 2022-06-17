# Git Writer Supply Chain

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

```dashboard:open-url
url: https://gitea.{{ingress_domain}}/gitea_admin/osscon-deliveries/src/branch/{{session_namespace}}-hello-world/config
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/delivery.yaml
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/source-git-repository.yaml
```

```editor:open-file
file: ~/exercises/examples/basic-delivery/app-operator/deploy-app.yaml
```



