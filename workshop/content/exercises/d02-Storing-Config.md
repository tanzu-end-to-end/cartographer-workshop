#### Storing the Deployment as Configuration

We're going to introduce some new templates that we will use to customize our supply chain. The first of these is the `ClusterConfigTemplate`. This is a template that stamps out a `CongigMap`. Our strategy here is that instead of outputting a Knative service to our local cluster, we are going to output a `ConfigMap` that stores the resource definition of our Knative service.

```editor:open-file
file: ~/exercises/examples/gitwriter-sc/app-operator/config-service.yaml
```

We see a new field in the `ClusterConfigTemplate`. Instead of the `template:` field which creates a static definition of the resource we want to produce, there is a field called `ytt:

Modify Supply Chain
```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/config-service.yaml
text: "ytt:"
```

[ytt](https://carvel.dev/ytt/) is an alternate templating approach (part of the open-source [Carvel](https://carvel.dev/) project), which allows us to introduce dynamic scripting with the [Starlark](https://bazel.build/rules/language) language.

The template defines a `service()` method that generates the descriptor for our Knative service:
```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/config-service.yaml
text: "def service"
before:0 
after: 0
```

It then embeds that service definition into a `ConfigMap`:
```editor:select-matching-text
file: ~/exercises/examples/gitwriter-sc/app-operator/config-service.yaml
text: "ConfigMap"
before: 1
after: 4
```

Let's go back to our supply chain definition:

```editor:select-matching-text
file: ~/exercises/supply-chain.yaml
text: "# kapp"
before: 0
after: 7
```

We are going to replace the final step of the supply chain, which deployed a Knative Service, with our new template that outputs a `ConfigMap`:

```editor:replace-text-selection
file: ~/exercises/supply-chain.yaml
text: |2
      # ConfigMap
      - name: config-provider
        templateRef:
          kind: ClusterConfigTemplate
          name:  osscon-app-config
        images:
          - resource: image-builder
            name: image
```

Now, how do we get this into Git?