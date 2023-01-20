# Helm chart for Matrix (Synapse + Element)

You can use this Helm chart to deploy Synapse, its backing PostgreSQL database, and the Element-Web frontend.

For example, to deploy both Synapse and Element at `chat.example.org`, with the domain part being simply `example.org` (e.g. `@user:example.org`, `#room:example.org`):

```
cat >values.yaml <'END'
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
END
helm upgrade --install chat --namespace chat -f values.yaml
```

You can also use a different domain for Synapse and Element, for example:

```
cat >values.yaml <'END'
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
END
helm upgrade --install chat --namespace chat -f values.yaml
```

For a list of the settings allowed in `homeserverConfig`, check out [Synapse's own documentation](https://matrix-org.github.io/synapse/latest/usage/configuration/config_documentation.html).
