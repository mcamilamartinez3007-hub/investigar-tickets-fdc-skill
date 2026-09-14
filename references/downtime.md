# Downtime: contratos y validación

## Separación obligatoria

- IDENTITY: qué evento lógico es.
- BUSINESS STATE: begin, end, reason, status.
- VERSION: qué representación o versión técnica se observa.
- AUDIT: creation, last update, load y sync.

La auditoría no debe crear por sí sola una identidad nueva ni representar un business change.

## Arquitectura objetivo de referencia

- DOWNTIME_ID: identidad canónica estable.
- DOWNTIME_UID: identidad de representación, versión o fuente.
- Begin/End/Reason/Status: estado funcional.
- Creation/LastUpdated/Load/Sync: auditoría.

## Investigación de duplicados

Capturar lineage mínimo:

- evento lógico;
- source UID;
- FDC UID;
- Enertia HID/TID;
- metric UIDs;
- creation timestamp;
- last update;
- sistema fuente;
- run o snapshot.

No usar ASSET_UID + BEGIN_DATETIME como identidad permanente sin demostrar unicidad y estabilidad. Begin puede cambiar y pueden existir eventos legítimos simultáneos.

## Fix idempotente

Antes de recomendar código, responder:

- ¿Qué contrato está roto?
- ¿Qué históricos existen?
- ¿Qué casos legítimos podría colapsar?
- ¿Funciona con retry y replay?
- ¿Qué hace con 0, 1 o más candidatos?
- ¿Qué hace con input obsoleto, corrección autoritativa o ejecución parcial?

Criterio estrella:

mismo input lógico dos veces → cero identidades nuevas

## Suite mínima

- create;
- reason edit;
- begin edit;
- end/close;
- reopen;
- delete;
- dos eventos el mismo día;
- overlap;
- open sentinel;
- retry;
- mismo input dos veces;
- FDC pendiente aún no disponible en Enertia;
- corrección autoritativa de Enertia;
- fuente obsoleta;
- run fallido;
- run parcial;
- múltiples candidatos;
- orphan histórico;
- cambio sólo de auditoría.

## Cleanup histórico

Orden:

1. Detener nueva corrupción.
2. Definir contrato canónico de identidad/versión.
3. Construir lineage/crosswalk.
4. Clasificar poblaciones históricas.
5. Reapuntar dependencias.
6. Inactivar representaciones excedentes.
7. Validar consumidores.
8. Borrar físicamente sólo si es requerido.

Categorías: duplicado técnico, evento legítimo, versión FDC, versión Enertia, linaje mixto, evento parcial y ambiguo. Nunca auto-deduplicar ambiguos.

## Estabilización

Objetivo consolidado:

canonical DOWNTIME_ID + persistent source crosswalk + Enertia authoritative state + FDC outbound ledger + semantic version/change detection + idempotent inbound reconciliation + atomic snapshot publication + metrics as projection + ambiguity to exception + lineage-aware cleanup.
