{{- if .Values.config.enabled }}
{{- $uniqueUpstreams := dict }}
{{- range .Values.config.files }}
{{- $uniqueUpstreams = set $uniqueUpstreams .upstream "" }}
{{- end }}

{{- range keys $uniqueUpstreams }}
---
kind: Service
apiVersion: v1
metadata:
  name: external-{{ . | replace "." "-" | lower | trunc 63 }}
spec:
  type: ExternalName
  externalName: {{ . }}
{{- end }}

{{- range .Values.config.files }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-config-{{ .path | replace "/" "-" | replace "." "-" | replace "_" "-" | lower }}
  annotations:
    kubernetes.io/ingress.class: ingress-nginx-public
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    nginx.ingress.kubernetes.io/upstream-vhost: "{{ .upstream }}"
    nginx.ingress.kubernetes.io/rewrite-target: "{{ .target }}"
spec:
  rules:
  - host: "config.{{ $.Values.domain }}"
    http:
      paths:
      - path: {{ .path }}
        pathType: Exact
        backend:
          service:
            name: external-{{ .upstream | replace "." "-" | lower | trunc 63 }}
            port:
              number: 443
{{- end }}
{{- end }}
