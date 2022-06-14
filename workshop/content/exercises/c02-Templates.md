## ClusterImageTemplate

```execute-1
kubectl apply -f /home/eduk8s/exercises/intro/02_templates/source.yaml
```

Image Template

```editor:open-file
file: /home/eduk8s/exercises/intro/01_manual/image.yaml
```

```editor:open-file
file: /home/eduk8s/exercises/intro/02_templates/image.yaml
```

```editor:select-matching-text
file: /home/eduk8s/exercises/intro/02_templates/image.yaml
text: "template"
before: 0
after: 17
```

```editor:select-matching-text
file: /home/eduk8s/exercises/intro/02_templates/image.yaml
text: "imagePath"
before: 0
after: 0
```

```editor:select-matching-text
file: /home/eduk8s/exercises/intro/02_templates/image.yaml
text: "apiVersion"
before: 0
after: 1
```

```editor:select-matching-text
file: /home/eduk8s/exercises/intro/02_templates/image.yaml
text: "url: (.*)"
isRegex: true
```

```editor:replace-text-selection
file: /home/eduk8s/exercises/intro/02_templates/image.yaml
text: "url: $(sources.source.url)$"
```

```execute-1
kubectl apply -f /home/eduk8s/exercises/intro/02_templates/image.yaml
```
