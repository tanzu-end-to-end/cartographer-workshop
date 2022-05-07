# Tanzu Application Platform Live Demonstration

Hello, this is our workshop, let's learn about Supply Chain Choreography!

---

Sanity check: docker push to session registry
```execute-1
echo $REGISTRY_PASSWORD | docker login -u $REGISTRY_USERNAME --password-stdin $REGISTRY_HOST
docker pull alpine
docker tag alpine $REGISTRY_HOST/alpine
docker push $REGISTRY_HOST/alpine
skopeo list-tags docker://$REGISTRY_HOST/alpine
```

Expected output of last (skopeo) command:
```shell
{
    "Repository": "$REGISTRY_HOST/alpine",
    "Tags": [
        "latest"
    ]
}
```
