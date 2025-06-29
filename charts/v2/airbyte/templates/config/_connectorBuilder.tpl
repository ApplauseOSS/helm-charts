
{{/* DO NOT EDIT: This file was autogenerated. */}}

{{/*
    Connectorbuilder Configuration
*/}}

{{/*
Renders the connectorBuilder secret name
*/}}
{{- define "airbyte.connectorBuilder.secretName" }}
{{- if .Values.connectorBuilderServer.secretName }}
    {{- .Values.connectorBuilderServer.secretName }}
{{- else }}
    {{- .Values.global.secretName | default (printf "%s-airbyte-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the connectorBuilderServer.aiAssistUrlBase value
*/}}
{{- define "airbyte.connectorBuilder.aiAssistUrlBase" }}
    {{- .Values.connectorBuilderServer.aiAssistUrlBase }}
{{- end }}

{{/*
Renders the connectorBuilder.aiAssistUrlBase environment variable
*/}}
{{- define "airbyte.connectorBuilder.aiAssistUrlBase.env" }}
- name: AI_ASSIST_URL_BASE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AI_ASSIST_URL_BASE
{{- end }}

{{/*
Renders the connectorBuilderServer.githubToken value
*/}}
{{- define "airbyte.connectorBuilder.githubToken" }}
    {{- .Values.connectorBuilderServer.githubToken }}
{{- end }}

{{/*
Renders the connectorBuilder.githubToken secret key
*/}}
{{- define "airbyte.connectorBuilder.githubToken.secretKey" }}
	{{- .Values.connectorBuilderServer.githubTokenSecretKey | default "BUILDER_GITHUB_AIRBYTE_PAT_TOKEN" }}
{{- end }}

{{/*
Renders the connectorBuilder.githubToken environment variable
*/}}
{{- define "airbyte.connectorBuilder.githubToken.env" }}
- name: BUILDER_GITHUB_AIRBYTE_PAT_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.connectorBuilder.secretName" . }}
      key: {{ include "airbyte.connectorBuilder.githubToken.secretKey" . }}
{{- end }}

{{/*
Renders the set of all connectorBuilder environment variables
*/}}
{{- define "airbyte.connectorBuilder.envs" }}
{{- include "airbyte.connectorBuilder.aiAssistUrlBase.env" . }}
{{- include "airbyte.connectorBuilder.githubToken.env" . }}
{{- end }}

{{/*
Renders the set of all connectorBuilder config map variables
*/}}
{{- define "airbyte.connectorBuilder.configVars" }}
AI_ASSIST_URL_BASE: {{ include "airbyte.connectorBuilder.aiAssistUrlBase" . | quote }}
{{- end }}

{{/*
Renders the set of all connectorBuilder secret variables
*/}}
{{- define "airbyte.connectorBuilder.secrets" }}
BUILDER_GITHUB_AIRBYTE_PAT_TOKEN: {{ include "airbyte.connectorBuilder.githubToken" . | quote }}
{{- end }}
