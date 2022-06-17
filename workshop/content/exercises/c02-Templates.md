Let's apply the same approach to templatizing the kpack Image resource.

^### ClusterImageTemplate

For the kpack Image, you will need a ClusterImageTemplate. This template takes arbitrary YAML as input and outputs one value: _image_.

#### Basic template

Create a new file with the basic configuration for a ClusterImageTemplate.

```editor:insert-lines-before-line
file: /home/eduk8s/exercises/image.yaml
line: 1
text: |-
    apiVersion: carto.run/v1alpha1
    kind: ClusterImageTemplate
    metadata:
      name: image-{{session_namespace}}
    spec:
      imagePath: 
      template:
```

The _template_ field can contain any arbitrary YAML configuration that you want Cartographer to submit to the Kubernetes API Server.
Since you want Cartographer to create the Image resource for you, copy the configuration that you applied manually in the manual step into this file.
In this case, use placeholders with values from the Workload instead of hard-coding "hello-world."
```editor:select-matching-text
file: /home/eduk8s/exercises/image.yaml
text: "template"
before: 0
after: 0
```

```editor:replace-text-selection
file: /home/eduk8s/exercises/image.yaml
text: |2
    template:
      apiVersion: kpack.io/v1alpha2
      kind: Image
      metadata:
        name: $(workload.metadata.name)$
      spec:
        tag: {{registry_host}}/$(workload.metadata.name)$
        serviceAccountName: default
        builder:
          kind: ClusterBuilder
          name: default
        source:
          blob:
            url: ${NEW_SOURCE}
```

By providing the Image configuration to the ClusterImageTemplate, you've given Cartographer the ability to create the resource and monitor its status.

#### Dynamic inputs

You already used placeholders to parameterize any values coming from the developer's Workload configuration.
However, you still need to enable Cartographer to inject the output from the ClusterSourceTemplate as input into the ClusterImageTemplate.
In other words, you need to parameterize `url: ${NEW_SOURCE}` in a way that Cartographer can understand.

Highlight the value that needs to be updated.
```editor:select-matching-text
file: /home/eduk8s/exercises/image.yaml
text: "${NEW_SOURCE}"
```

Replace it with a placeholder using the `sources` context.
In a few steps you will see why this variable name is correct.
For now, it is enough to know that this variable will contain the value that Cartographer will extract from the GitRepository resource.
```editor:replace-text-selection
file: /home/eduk8s/exercises/image.yaml
text: "$(sources.source.url)$"
```

#### Output path
Recall the value that you copied from the Image resource status to the Service resource: `.status.latestImage`.

In order for Cartographer to extract the same value automatically, you need to provide the **path** to the value.

```editor:select-matching-text
file: /home/eduk8s/exercises/image.yaml
text: "imagePath"
before: 0
after: 0
```

```editor:replace-text-selection
file: /home/eduk8s/exercises/image.yaml
text: "  imagePath: .status.latestImage\n"
```

Now, Cartographer can create the resource, monitor its status, and extract the desired value.

Your ClusterImageTemplate can now be used to create Image resources for any number of applications!
