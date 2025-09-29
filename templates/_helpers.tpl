{{- define "nats.instance" -}}
{{- default .Release.Name .Values.nats.instance -}}
{{- end }}
