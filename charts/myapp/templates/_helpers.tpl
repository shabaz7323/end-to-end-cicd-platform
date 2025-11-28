{{- define "myapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "myapp.fullname" -}}
{{- printf "%s-%s" (include "myapp.name" .) .Release.Namespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}
