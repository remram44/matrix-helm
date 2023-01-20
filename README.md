# Helm chart for Matrix (Synapse + Element)

You can use this Helm chart to deploy Synapse, its backing PostgreSQL database, and the Element-Web frontend.

```
helm repo add matrix https://remram44.github.io/matrix-helm
helm install chat matrix/matrix --namespace chat -f values.yaml
```

For example, to deploy both Synapse and Element at `chat.example.org`, with the domain part being simply `example.org` (e.g. `@user:example.org`, `#room:example.org`):

```yaml
homeserverConfig:
  server_name: example.org
  public_baseurl: https://chat.example.org/
  web_client_location: https://chat.example.org/
  email:
    app_name: Example Chat
ingress:
  enabled: true
  hosts:
    - chat.example.org
  tls:
    - hosts:
        - chat.example.org
        - example.org
element:
  config:
    default_server_config:
      m.homeserver:
        base_url: https://chat.example.org
        server_name: Example Chat
  ingress:
    enabled: true
    host: chat.example.org
```

You can also use a different domain for Synapse and Element, for example:

```yaml
homeserverConfig:
  server_name: example.org
  public_baseurl: https://synapse.example.org/
  web_client_location: https://element.example.org/
  email:
    app_name: Example Chat
ingress:
  enabled: true
  hosts:
    - synapse.example.org
  tls:
    - hosts:
        - synapse.example.org
        - example.org
element:
  config:
    default_server_config:
      m.homeserver:
        base_url: https://synapse.example.org
        server_name: Example Chat
  ingress:
    enabled: true
    host: element.example.org
```

For a list of the settings allowed in `homeserverConfig`, check out [Synapse's own documentation](https://matrix-org.github.io/synapse/latest/usage/configuration/config_documentation.html).
