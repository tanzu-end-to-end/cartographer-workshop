# Tanzu Application Platform Live Demonstration

Hello, this is our workshop, let's learn about Supply Chain Choreography!

```execute-1
git clone https://github.com/ciberkleid/cartographer-concepts.git 
```

```editor:open-file
/home/eduk8s/cartographer-concepts/layout-2/01_manual/source.yaml
```

```editor:open-file
/home/eduk8s/cartographer-concepts/layout-2/01_manual/image.yaml
```

```editor:open-file
/home/eduk8s/cartographer-concepts/layout-2/01_manual/app-deploy.yaml
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
