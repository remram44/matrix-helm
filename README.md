# Helm chart for Matrix (Synapse + Element)

You can use this Helm chart to deploy Synapse, its backing PostgreSQL database, and the Element-Web frontend.

For example, to deploy both Synapse and Element at `chat.example.org`, with the domain part being simply `example.org` (e.g. `@user:example.org`, `#room:example.org`):

```
helm upgrade --install chat --namespace chat \
    --set server_name=example.org \
    --set server_public_url=https://chat.example.org/ \
    --set app_name="Example Chat" \
    --set ingress.enabled=true \
    --set ingress.hosts[0]=chat.example.org \
    --set ingress.tls[0].hosts[0]=chat.example.org \
    --set element.homeserver.base_url=https://chat.example.org \
    --set element.homeserver.name="Example Chat" \
    --set element.ingress.enabled=true \
    --set element.ingress.host=chat.example.org \
    --set element.ingress.tls[0].hosts[0]=chat.example.org
```

You can also use a different domain for Synapse and Element, for example:

```
helm upgrade --install chat --namespace chat \
    --set server_name=example.org \
    --set server_public_url=https://synapse.example.org/ \
    --set app_name="Example Chat" \
    --set ingress.enabled=true \
    --set ingress.hosts[0]=synapse.example.org \
    --set ingress.tls[0].hosts[0]=synapse.example.org \
    --set element.homeserver.base_url=https://synapse.example.org \
    --set element.homeserver.name="Example Chat" \
    --set element.ingress.enabled=true \
    --set element.ingress.host=element.example.org \
    --set element.ingress.tls[0].hosts[0]=element.example.org
```

Other settings exist, for example for email, check the `values.yaml` files for the full list.
