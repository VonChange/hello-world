{{/* vim: set filetype=mustache: */}}
{{- /*
service.labels.standard prints the standard service Helm labels.
The standard labels are frequently used in metadata.
*/ -}}
{{- define "service.labels.standard" -}}
k8s-app: {{ .Values.service.name | quote }}
{{- end -}}
{{- define "monitor.labels.standard" -}}
monitor: enabled
{{- end -}}
{{- define "service.match.labels" -}}
k8s-app: {{ .Values.service.name | quote }}
{{- end -}}


