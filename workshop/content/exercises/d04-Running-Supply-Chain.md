
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
