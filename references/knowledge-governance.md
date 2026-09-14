# Gobierno del conocimiento

## Registro mínimo

Cada conocimiento extraído debe registrar:

- source
- ticket
- date
- environment
- domain
- evidence_type
- confidence
- validity
- supersedes
- related_tickets
- requires_revalidation

## Estados de vigencia

- current: confirmado y aplicable.
- historical: válido para una versión o periodo anterior.
- superseded: reemplazado por decisión o implementación posterior.
- contradicted: existe evidencia directa incompatible.
- unverified: proviene de memoria o narrativa sin corroboración.
- environment-specific: aplica sólo al ambiente indicado.

## Memoria frente a evidencia

La memoria y los chats ayudan a localizar conocimiento, pero Jira, datos, runtime y código activo lo corroboran. No presentar como fuente abierta un chat que no esté en el contexto o adjunto.

## Ingesta futura

1. Incorporar fuente original sin modificar en source-material/.
2. Clasificar secretos y PII; excluir lo innecesario.
3. Extraer hechos con metadata.
4. Relacionar tickets, objetos y dominios.
5. Detectar contradicciones y supersession.
6. Actualizar referencias derivadas.
7. Ejecutar evaluaciones.
8. Registrar cambio en CHANGELOG.

## Prohibiciones

- No copiar credenciales, tokens ni accesos.
- No reemplazar silenciosamente una regla histórica.
- No usar el cierre de Jira como prueba técnica.
- No incorporar hipótesis como conocimiento current.
- No convertir SKILL.md en un volcado documental.
