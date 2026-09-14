# Registro de fuentes de verdad

Este registro es contextual, no universal.

| Dominio/pregunta | Fuente prioritaria inicial | Confirmación requerida |
|---|---|---|
| Comportamiento ocurrido | Runtime y logs | Run, ambiente y ventana |
| Contenido real | Datos del ambiente afectado | Snapshot o query fechado |
| Mecanismo implementado | Código/configuración activa | Rama, versión o deployment |
| Expectativa funcional | Decisión vigente de negocio/Jira | Owner y fecha |
| Downtime objetivo | Enertia cuando el contrato vigente lo define | Flujo y ventana específica |
| Identidad creada en cliente | FDC App/Web/Mobile/Core | Caso antes del pipeline |
| Publicación de Exceptions | Salida Accordia + Warehouse API | Contrato del endpoint/consumidor |
| Historian | Pipeline y consumidor Historian | Aceptación del owner |
| Estado de entrega | Evidencia de implementación/validación/deploy | No inferir del status Jira |

## Regla temporal

Cada afirmación debe tener ambiente, fecha y vigencia. Si una fuente histórica contradice runtime actual, conservar ambas y marcar la histórica como reemplazada o limitada, no borrarla.

## Registro de estados

Separar:

- estado administrativo;
- estado de implementación;
- estado de validación;
- estado de despliegue;
- estado del conocimiento;
- ticket donde continúa el trabajo.
