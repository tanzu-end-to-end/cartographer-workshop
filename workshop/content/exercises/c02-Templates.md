## ClusterImageTemplate

```execute-1
kubectl apply -f /home/eduk8s/intro/02_templated/source.yaml
```

Image Template

```editor:open-file
file: /home/eduk8s/intro/01_manual/image.yaml
```

```editor:open-file
file: /home/eduk8s/intro/02_templated/image.yaml
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/image.yaml
text: "template"
before: 0
after: 17
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/image.yaml
text: "imagePath"
before: 0
after: 0
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/image.yaml
text: "apiVersion"
before: 0
after: 1
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/image.yaml
text: "url: (.*)"
isRegex: true
```

```editor:replace-text-selection
file: /home/eduk8s/intro/02_templated/image.yaml
text: "url: $(sources.source.url)$"
```

```execute-1
kubectl apply -f /home/eduk8s/intro/02_templated/image.yaml
```
