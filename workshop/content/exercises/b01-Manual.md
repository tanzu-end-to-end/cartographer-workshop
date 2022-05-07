# Manual Application Deployment

```execute-1
git clone https://github.com/ciberkleid/cartographer-concepts.git
find ./cartographer-concepts -type f -not -path '*/\.*' -print0 | xargs -0 sed -i "s/harbor\.tanzu\.coraiberkleid\.site\/carto-demo/$REGISTRY_HOST/g"
```

```editor:open-file
file: /home/eduk8s/cartographer-concepts/layout-2/01_manual/source.yaml
```

```editor:open-file
file: /home/eduk8s/cartographer-concepts/layout-2/01_manual/image.yaml
```

```editor:open-file
file: /home/eduk8s/cartographer-concepts/layout-2/01_manual/app-deploy.yaml
```

```execute-1
kubectl apply -f /home/eduk8s/cartographer-concepts/layout-2/01_manual/source.yaml
```

```execute-1
kubectl get gitrepository hello-world -o yaml | yq .status
```

```execute-1
kubectl get gitrepository hello-world -o yaml | yq .status.artifact.url
```

```editor:select-matching-text
file: /home/eduk8s/cartographer-concepts/layout-2/01_manual/image.yaml
text: "${NEW_SOURCE}"
```

```execute-1
kubectl apply -f /home/eduk8s/cartographer-concepts/layout-2/01_manual/image.yaml
```

```execute-1
kubectl get imgs hello-world
```

```execute-1
kp build logs hello-world
```

```execute-1
kubectl get imgs hello-world -o yaml | yq .status
```


```execute-1
kubectl apply -f /home/eduk8s/cartographer-concepts/layout-2/01_manual/image.yaml
```

```execute-1
kubectl get imgs hello-world -o yaml | yq .status.latestImage
```

```editor:select-matching-text
file: /home/eduk8s/cartographer-concepts/layout-2/01_manual/app-deploy.yaml
text: "${NEW_IMAGE}"
```