{{/*
Expand the name of the chart.
*/}}
{{- define "paperclip.name" -}}
{{- default .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "paperclip.fullname" -}}
{{- if contains .Chart.Name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paperclip.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "paperclip.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paperclip.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperclip.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service account name
*/}}
{{- define "paperclip.serviceAccountName" -}}
{{- if .Values.paperclip.serviceAccount.create }}
{{- default (include "paperclip.fullname" .) .Values.paperclip.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.paperclip.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Image reference
*/}}
{{- define "paperclip.image" -}}
{{- $tag := default .Chart.AppVersion .Values.paperclip.image.tag -}}
{{ printf "%s:%s" .Values.paperclip.image.repository $tag }}
{{- end }}

{{/*
Database secret name
*/}}
{{- define "paperclip.dbSecretName" -}}
{{- if .Values.paperclip.postgres.existingSecret }}
{{- .Values.paperclip.postgres.existingSecret }}
{{- else }}
{{- printf "%s-db" (include "paperclip.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Database secret key
*/}}
{{- define "paperclip.dbSecretKey" -}}
{{- if .Values.paperclip.postgres.existingSecret }}
{{- .Values.paperclip.postgres.existingSecretKey }}
{{- else }}
{{- "url" }}
{{- end }}
{{- end }}

{{/*
Auth secret name
*/}}
{{- define "paperclip.authSecretName" -}}
{{- if .Values.paperclip.auth.existingSecret }}
{{- .Values.paperclip.auth.existingSecret }}
{{- else }}
{{- printf "%s-auth" (include "paperclip.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Auth secret key
*/}}
{{- define "paperclip.authSecretKey" -}}
{{- if .Values.paperclip.auth.existingSecret }}
{{- .Values.paperclip.auth.existingSecretKey }}
{{- else }}
{{- "secret" }}
{{- end }}
{{- end }}
