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
kubectl create secret docker-registry registry-credentials \
        --docker-server=$REGISTRY_HOST \
        --docker-username=$REGISTRY-USERNAME \
        --docker-password=$REGISTRY-PASSWORD

```

```execute-1
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: default
secrets:
  - name: registry-credentials
imagePullSecrets:
  - name: registry-credentials
EOF
```

```execute-1
kubectl apply -f /home/eduk8s/cartographer-concepts/layout-2/01_manual/image.yaml
```

```execute-1
kubectl get imgs hello-world
```

```execute-1
#kp build logs hello-world
kubectl get pods
```

```execute-1
skopeo list-tags docker://$REGISTRY_HOST/hello-world
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
