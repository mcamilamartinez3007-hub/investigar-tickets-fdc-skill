# Conocimiento FDC consolidado para la skill

Esta referencia conserva las reglas entregadas para reorganizar investigar-tickets-fdc. Es conocimiento derivado del trabajo previo y debe contrastarse con fuentes activas cuando cambien ambiente, versión o fecha.

## Reglas centrales

1. Contexto primero: leer adjuntos, handoffs, reportes, logs, código y resultados previos antes de preguntar.
2. Seguir síntoma → flujo real → primera desviación → mecanismo → causa → impacto → fix → estabilización.
3. Separar CONFIRMED, HYPOTHESIS, UNKNOWN y NEXT VALIDATION.
4. Priorizar runtime, datos, código y configuración activa sobre narrativa histórica.
5. Responder primero dónde aparece el síntoma, quién lo creó, qué identidad tenía y qué esperaba la siguiente capa.
6. Investigar identidad antes de deduplicar.
7. Separar identidad, business state, versión y auditoría.
8. No usar auditoría como identidad ni business change.
9. Mantener separados 428, 458 y 459.
10. No tratar el Overhaul 2025 como implementación literal de FDCSD-183.
11. Producir fix inmediato y estabilización cuando el mecanismo sea sistémico.
12. Validar idempotencia, retry, replay y ambigüedad.
13. Detener nueva corrupción antes del cleanup histórico.
14. Entregar siempre síntoma, expectativa, flujo, hechos, descartes, preguntas, causa o mejor mecanismo, impacto, opciones, recomendación, riesgos, validación, evidencia y siguiente acción.

## Downtime 428

FDCUpdateID nulo es permitido para registros Enertia. El defecto consolidado no es el nulo: es la ausencia de resolución de identidad idempotente cuando ese campo no permite reutilizar DOWNTIME_UID. El merge observado usa DOWNTIME_UID como clave y agrega inserts no encontrados; los SP del overhaul citados actúan sobre métricas y no limpian FDC_DOWNTIME. La población medida mostró pares, no una acumulación infinita demostrada.

## Downtime 459

Un reason edit en el golden sample produjo un nuevo UID antes del pipeline. El código de cliente/core invalida, clona y genera GUID. Corresponde a versionado en FDC client/core y no comparte automáticamente la RCA de 428.

## Downtime 458

Trata propagación y representación temporal. Las diferencias observadas no demuestran por sí solas retrigger, timezone como causa ni equivalencia con 428/459.

## Estabilización objetivo

Identidad canónica, crosswalk persistente, estado autoritativo Enertia, ledger outbound FDC, detección semántica de cambios, reconciliación inbound idempotente, publicación atómica, métricas como proyección, ambigüedad a exceptions y cleanup con lineage.

## Continuidad

Al invocar $investigar-tickets-fdc FDCSD-XYZ, recuperar evidencia y continuar desde la última incertidumbre. No volver a solicitar SQL, archivos, tickets, repositorios, DAGs, capturas o validaciones ya disponibles.
