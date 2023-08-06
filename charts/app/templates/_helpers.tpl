{{/* Generate basic labels */}}

{{- define "selectorLabels" }}
  appName: {{ .Chart.Name | quote }}
  release: {{ .Release.Name | quote }}
{{- end }}

{{- define "labels" }}
  labels:
    {{- include "selectorLabels" . | indent 2 }}
    chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{- end }}