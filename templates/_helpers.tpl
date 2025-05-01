{{- define "valkey_password" -}}
{{- default (randAlphaNum 32) .Values.valkeyPassword }}
{{- end -}}
