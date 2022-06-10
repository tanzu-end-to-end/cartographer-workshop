![img.png](images/cartographer.png)

```execute-1
kubectl api-resources | grep carto | grep template
```

SourceTemplate

```editor:open-file
file: /home/eduk8s/intro/01_manual/source.yaml
```

```editor:open-file
file: /home/eduk8s/intro/02_templated/source.yaml
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/source.yaml
text: "template"
before: 0
after: 11
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/source.yaml
text: "urlPath"
before: 0
after: 1
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/source.yaml
text: "apiVersion"
before: 0
after: 1
```

```editor:open-file
file: /home/eduk8s/intro/04_workload.yaml
```

```editor:select-matching-text
file: /home/eduk8s/intro/04_workload.yaml
text: "apiVersion"
before: 0
after: 1
```

```editor:select-matching-text
file: /home/eduk8s/intro/04_workload.yaml
text: "url"
before: 0
after: 2
```

```editor:open-file
file: /home/eduk8s/intro/02_templated/source.yaml
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/source.yaml
text: "https://github.com/ciberkleid/hello-go"
```

```editor:replace-text-selection
file: /home/eduk8s/intro/02_templated/source.yaml
text: $(workload.spec.source.git.url)$
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/source.yaml
text: "ref:"
isRegex: true
before: 0
after: 1
```

```editor:replace-text-selection
file: /home/eduk8s/intro/02_templated/source.yaml
text: "      ref: $(workload.spec.source.git.ref)$\n"
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/source.yaml
text: "hello-world"
```

```editor:replace-text-selection
file: /home/eduk8s/intro/02_templated/source.yaml
text: "$(workload.metadata.name)$"
```

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

Deploy Template

```editor:open-file
file: /home/eduk8s/intro/01_manual/app-deploy.yaml
```

```editor:open-file
file: /home/eduk8s/intro/02_templated/app-deploy.yaml
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/app-deploy.yaml
text: "template"
before: 0
after: 53
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/app-deploy.yaml
text: "imagePath"
before: 0
after: 0
```

```editor:select-matching-text
file: /home/eduk8s/intro/02_templated/app-deploy.yaml
text: "apiVersion"
before: 0
after: 1
```

