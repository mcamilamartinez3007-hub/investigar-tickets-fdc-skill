---
name: investigar-tickets-fdc
description: Investiga tickets FDC de extremo a extremo usando evidencia disponible en archivos, Jira, código, SQL, Snowflake, Airflow, APIs, Web y Mobile. Reconstruye el flujo real, separa hechos de hipótesis, identifica la primera desviación demostrable y entrega diagnóstico, validaciones, fix mínimo, estabilización y evidencia lista para Jira. Úsala al trabajar un ticket FDC nuevo o existente, continuar una investigación previa, analizar duplicados, sincronización, Downtime, Visits, rutas, usuarios, Historian, inbound/outbound o fallas operacionales.
---

# Investigar tickets FDC

## Objetivo

Continuar cada investigación desde el último punto comprobado y producir una respuesta técnica trazable, rápida y accionable para ingenieros junior o senior.

La secuencia rectora es:

síntoma → flujo real → primera desviación demostrable → mecanismo técnico → causa → impacto → fix mínimo → estabilización si es sistémico

No buscar solamente algo raro. No convertir correlación en causalidad.

## Regla de contexto primero

Antes de investigar:

1. Leer completamente los archivos relevantes del chat actual.
2. Buscar handoffs, reportes, logs, código, resultados SQL y documentos previos disponibles.
3. Recuperar investigaciones anteriores y conocimiento vigente del ticket.
4. Consultar Jira cuando haga falta historia, requerimiento, decisión o evidencia externa al código.
5. Pedir información o una nueva ejecución solamente cuando no exista evidencia suficiente o se requiera una medición nueva.

No volver a pedir un archivo, query, captura o validación ya disponible. No reiniciar por cambio de chat.

## Límites de operación

Esta skill es de análisis y recomendación.

- Trabajar en modo lectura sobre Jira, repositorios, bases, logs y configuraciones.
- No comentar, editar, cerrar ni transicionar tickets.
- No ejecutar SQL ni comandos operacionales.
- No promover cambios entre ambientes.
- No modificar repositorios ni infraestructura salvo que el usuario lo pida de forma explícita en esa conversación.
- No exponer credenciales, tokens, enlaces privados, PII innecesaria ni secretos.
- Entregar queries y acciones para ejecución humana autorizada.

## Modelo de evidencia

Etiquetar toda afirmación importante:

- CONFIRMED: evidencia directa.
- HYPOTHESIS: explicación compatible aún no probada.
- UNKNOWN: información no conocida.
- NEXT VALIDATION: prueba con mayor capacidad de reducir incertidumbre.

Prioridad ante contradicciones:

1. Runtime real y logs.
2. Datos reales.
3. Código activo.
4. Configuración activa.
5. Jira y decisiones funcionales.
6. Documentación de diseño.
7. Comentarios históricos.
8. Hipótesis.

El estado administrativo de Jira no demuestra implementación, validación, despliegue ni vigencia técnica.

## Inicio mínimo

Responder primero:

- ¿Dónde aparece por primera vez el síntoma?
- ¿Qué sistema lo creó?
- ¿Qué identidad tenía allí?
- ¿Qué esperaba recibir la siguiente capa?
- ¿Qué recibió realmente?

Preferir pruebas discriminantes A/B frente a recorridos masivos. No inspeccionar decenas de tablas por si acaso.

## Selección de referencias

Leer según el caso:

- Metodología general y cierre: references/methodology.md
- Arquitectura, flujos y granularidad: references/architecture-and-lineage.md
- Identidad y Downtime: references/downtime.md
- Casos conocidos y guardrails: references/known-cases.md
- Responsabilidades y dependencias: references/ownership-and-dependencies.md
- Fuentes autoritativas: references/source-of-truth-registry.md
- Vigencia y actualización del conocimiento: references/knowledge-governance.md
- Comunicación al cliente: references/client-collaboration.md
- Fuentes técnicas disponibles o pendientes: references/source-material-manifest.md
- Instrucciones consolidadas originales: references/conocimiento-fdc-completo.md

No cargar todas las referencias si el ticket no las necesita.

## Flujo de investigación

1. Definir síntoma, expectativa de negocio, ambiente y ventana temporal.
2. Recuperar evidencia previa y establecer qué ya está confirmado.
3. Dibujar el recorrido fuente → transformaciones → destinos → consumidor.
4. Registrar identidad, grano, timestamps y estado por frontera.
5. Encontrar la primera capa donde esperado y real divergen.
6. Revisar el mecanismo activo que puede producir esa diferencia.
7. Descartar hipótesis incompatibles con la evidencia.
8. Declarar RCA sólo cuando mecanismo y caso observado formen una cadena demostrable.
9. Proponer fix mínimo y, si aplica, plan de estabilización separado.
10. Diseñar validaciones de regresión, retry, replay, ambigüedad y recuperación.
11. Preparar evidencia interna en español y actualización externa en inglés.

## Duplicados e identidad

Nunca empezar con DISTINCT, ROW_NUMBER, DELETE o deduplicación.

Determinar primero si las filas son:

- el mismo evento;
- versiones del mismo evento;
- eventos legítimos diferentes;
- representaciones de sistemas distintos;
- corrupción o linaje ambiguo.

Una business key sirve para descubrir candidatos; no es automáticamente una identidad permanente.

## Criterio para cerrar la investigación

La RCA está cerrada únicamente si existe:

- síntoma reproducido o evidencia equivalente;
- primera desviación identificada;
- mecanismo técnico activo;
- cadena causal coherente con el caso;
- hipótesis principales descartadas;
- impacto delimitado;
- validación capaz de confirmar el fix.

Si falta alguno, entregar CURRENT BEST MECHANISM y declarar que la RCA sigue abierta.

## Formato obligatorio de salida

- SYMPTOM
- BUSINESS EXPECTATION
- CURRENT FLOW
- CONFIRMED FACTS
- DISCARDED HYPOTHESES
- OPEN QUESTIONS
- ROOT CAUSE o CURRENT BEST MECHANISM
- IMPACT
- FIX OPTIONS
- RECOMMENDED FIX
- REGRESSION / STABILIZATION RISKS
- VALIDATION PLAN
- EVIDENCE FOR JIRA
- NEXT ACTION

Usar assets/investigation-template.md. Para comunicaciones externas, usar assets/client-update-template.md.

## Idioma y estilo

- Análisis interno y explicación al ingeniero: español claro.
- Texto para Jira, cliente, handoff o UAT: inglés profesional y directo.
- Mostrar hechos, inferencias y vacíos por separado.
- Evitar narrativas largas cuando una conclusión accionable es suficiente.
- No vestir una hipótesis con corbata y llamarla causa raíz.
