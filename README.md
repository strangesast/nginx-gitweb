edit nginx ingress DaemonSet config:

[Create ConfigMap for TCP passthrough](https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/)
```
apiVersion: v1
kind: ConfigMap
data:
  "2222": gitweb/gitweb:2222
```

Edit DaemonSet arguments to use TCP passthrough
```
- args:
  - /nginx-ingress-controller
  ...
  - --tcp-services-configmap=$(POD_NAMESPACE)/nginx-ingress-tcp-microk8s-conf
  ...
```

Edit DaemonSet exposed ports
```
ports:
...
- containerPort: 2222
  hostPort: 2222
  name: ssh
  protocol: TCP
...
```
