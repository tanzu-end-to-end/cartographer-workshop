Finally, apply the same approach to templatizing the Knative Serving Service resource.

## ClusterTemplate

For the Knative Serving Service, you will need a ClusterTemplate. This template takes arbitrary YAML as input. It does not produce any output values.

#### Basic template

Create a new file with the basic configuration for a ClusterTemplate.
```editor:insert-lines-before-line
file: /home/eduk8s/exercises/app-deploy.yaml
line: 1
text: |-
    apiVersion: carto.run/v1alpha1
    kind: ClusterTemplate
    metadata:
      name: app-deploy-{{session_namespace}}
      annotations:
        janitor/ttl: 2h
    spec:
      template:
```

The _template_ field can contain any arbitrary YAML configuration that you want Cartographer to submit to the Kubernetes API Server.
Since you want Cartographer to create the Service resource for you, you'll want to copy the configuration that you applied manually in the manual step into this file.

In this case, however, it's preferable to wrap the Knative configuration with a [Kapp Controller App](https://carvel.dev/kapp-controller/docs/v0.38.0/app-overview) resource.

> **Why Kapp Controller?**
>
> The Knative Serving controller updates the service under the hood to include additional annotations that cannot be mutated once they have been applied.
> Kapp Controller is helpful in this case because it enables you to disable patching to these annotations.

Populate the template with the Kapp Controller configuration first.
```editor:select-matching-text
file: /home/eduk8s/exercises/app-deploy.yaml
text: template
before: 0
after: 0
```

```editor:replace-text-selection
file: /home/eduk8s/exercises/app-deploy.yaml
text: |2
    template:
      apiVersion: kappctrl.k14s.io/v1alpha1
      kind: App
      metadata:
        name: $(workload.metadata.name)$
      spec:
        serviceAccountName: default
        template:
          - ytt: { }
        deploy:
          - kapp: { }
        fetch:
          - inline:
              paths:
                manifest.yml: |
                  ---
                  apiVersion: kapp.k14s.io/v1alpha1
                  kind: Config
                  rebaseRules:
                    - path:
                        - metadata
                        - annotations
                        - serving.knative.dev/creator
                      type: copy
                      sources: [new, existing]
                      resourceMatchers: &matchers
                        - apiVersionKindMatcher:
                            apiVersion: serving.knative.dev/v1
                            kind: Service
                    - path:
                        - metadata
                        - annotations
                        - serving.knative.dev/lastModifier
                      type: copy
                      sources: [new, existing]
                      resourceMatchers: *matchers
```

Now, add the configuration for the Service that you applied manually earlier.

```editor:append-lines-to-file
file: /home/eduk8s/exercises/app-deploy.yaml
text: |2
                  ---
                  apiVersion: serving.knative.dev/v1
                  kind: Service
                  metadata:
                    name: $(workload.metadata.name)$
                  spec:
                    template:
                      metadata:
                        annotations:
                          autoscaling.knative.dev/minScale: "1"
                      spec:
                        serviceAccountName: default
                        containers:
                          - name: workload
                            image: ${NEW_IMAGE}
                            securityContext:
                              runAsUser: 1000
```

By providing the Service configuration to the ClusterTemplate, you've given Cartographer the ability to create the resource and monitor its status.

#### Dynamic inputs

You already used placeholders to parameterize any values coming from the developer's Workload configuration.
However, you still need to enable Cartographer to inject the output from the ClusterImageTemplate as input into the ClusterTemplate.
In other words, you need to parameterize `url: ${NEW_IMAGE}` in a way that Cartographer can understand.

Highlight the value that needs to be updated.
```editor:select-matching-text
file: /home/eduk8s/exercises/app-deploy.yaml
text: ${NEW_IMAGE}
```

Replace it with a placeholder using the `images` context.
In a few steps you will see why this variable name is correct.
For now, it is enough to know that this variable will contain the value that Cartographer will extract from the Image resource.
```editor:replace-text-selection
file: /home/eduk8s/exercises/app-deploy.yaml
text: $(images.image.image)$
```

Now, Cartographer can create the resource and monitor its status.

Your ClusterTemplate can now be used to create Service resources for any number of applications!
