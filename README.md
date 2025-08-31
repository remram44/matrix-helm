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

Synapse can be hosted directly on your root domain (e.g. `example.org`) as well. It just exposes `/_matrix`, `/_synapse` and optionally `/.well-known/matrix`.
If Synapse is hosted on a subdomain (e.g. `synapse.example.org`) and you want to use federation via `.well-known`, make sure `/.well-known/matrix` is available on your root domain (e.g. `example.org`) - for example by deploying an additional Ingress.

For a list of the settings allowed in `homeserverConfig`, check out [Synapse's own documentation](https://element-hq.github.io/synapse/latest/usage/configuration/config_documentation.html).

## Troubleshooting

### path /.well-known/matrix cannot be used with pathType Prefix

If you use DNS records for federation, you can set `ingress.exposeWellKnown` to `false`.
Otherwise you need to relax the ingress-nginx controller validation by setting `controller.config.strict-validate-path-type` to `"false"`.
See: https://github.com/kubernetes/ingress-nginx/issues/11176

### matrix-federation://matrix.org/\_matrix/federation/...: HttpResponseException('401: Unauthorized')

You need to advertise your Matrix server via DNS SRV record or `.well-known` path on your root domain (see notes above).
