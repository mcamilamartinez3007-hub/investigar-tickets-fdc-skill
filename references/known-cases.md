# Casos conocidos y guardrails

## FDCSD-428

Estado actual confirmado:

- DOWNTIME_MASTER se reconstruye desde Enertia.
- FDCUpdateID nulo es intencional para registros originados en Enertia.
- El staging intenta reutilizar identidad mediante MST.FDCUpdateID = DT.DOWNTIME_UID.
- La construcción usa COALESCE(FDCUpdateID, DT.DOWNTIME_UID, UUID_STRING()).
- Si FDCUpdateID es nulo y el join no resuelve una identidad previa, puede generarse un nuevo DOWNTIME_UID.
- La alternativa de matching funcional se encontró comentada.
- Los procedimientos Usp_Inactivate_OldDwntmRecords y Usp_Delete_OldDwntmRecords actúan sobre FDC_VISIT_METRIC para MTR052/MTR085/MTR051, no sobre FDC_DOWNTIME.
- Después de esos procedimientos corre fdc_downtime_merge_reverse_etl.
- Runtime observado: source FDC_STG_DOWNTIME_MERGE, target dbo.FDC_DOWNTIME, merge key DOWNTIME_UID, MATCHED UPDATE y NOT MATCHED INSERT; no se observó NOT MATCHED BY SOURCE para delete/inactivate.
- Evidencia de una ejecución: 52,324 source rows, 0 updates, 52,324 inserts.
- Población observada: 27,575 eventos lógicos, 55,150 filas físicas, 27,575 excedentes y grupos con UID_COUNT = 2.

Formulación correcta: FDCUpdateID nulo no es la causa raíz. El defecto es que el pipeline carece de resolución de identidad idempotente para ese escenario.

No afirmar acumulación infinita A+B+C+D: la evidencia citada confirma exactamente dos identidades en esa población.

## FDCSD-459

Mecanismo confirmado distinto:

- En el golden sample de JT, un reason-only edit cambió el UID 6656592E... a 2885CA1E....
- El nuevo UID apareció antes de CF/dbt/Accordia.
- AssetMetricsViewModel contiene InvalidateAndCreateDowntimeRecord(), que invalida la versión previa, clona y usa Guid.NewGuid().
- Métricas asociadas también pueden recibir nuevos GUID.

Lectura: 459 corresponde a identidad/versionado creado en FDC client/core.

Posible interacción no confirmada: App/Web UID A → UID B → round-trip Enertia → Data UID C. Probar end-to-end con el golden sample antes de declararla.

## FDCSD-458

Mantener separado:

- Alcance: LASTUPDATED, LAST_UPDATE y propagación temporal/versionado.
- Existen diferencias sistémicas de representación temporal.
- No está demostrado que causen el re-surfacing del external exception service.

No concluir sin evidencia nueva:

- 458 = 428;
- 458 = 459;
- diferencia temporal = retrigger;
- timezone = causa.

## Historia: FDCSD-183 y Overhaul 2025

FDCSD-183 propuso identidad canónica, DOWNTIME_ID, reconciliación, prioridad Enertia, ledger outbound, exceptions y cambios de clientes/DTOs.

El Overhaul 2025 evolucionó a Enertia authoritative source, VW_DOWNTIME_ALL, rolling six months plus older opens, freshness gate, inactivate/delete de métricas, reload desde Enertia y orquestación separada.

No tratar el overhaul como implementación literal de FDCSD-183. Persigue consistencia, pero reemplaza gran parte de la identidad canónica con authoritative refresh. El hallazgo de 2026 es que la intención de replacement no quedó completamente reflejada en FDC_DOWNTIME, donde persistió el upsert por UID.
