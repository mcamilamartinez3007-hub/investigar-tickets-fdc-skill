# investigar-tickets-fdc-skill

Skill reutilizable para investigar tickets FDC con evidencia trazable, reconstrucción de lineage y separación estricta entre hechos, hipótesis e incógnitas.

## Qué resuelve

- Continúa investigaciones existentes sin reiniciar desde cero.
- Reconstruye recorridos entre FDC, App/Web/Mobile, APIs, SQL Server, Airflow, dbt, Snowflake, PostgreSQL/Timescale, Enertia e Historian.
- Identifica la primera desviación demostrable.
- Separa incident fix, recovery, cleanup y estabilización.
- Produce evidencia técnica y comunicaciones en inglés listas para revisión humana.

## Uso

Invocación recomendada:

$investigar-tickets-fdc FDCSD-XYZ

También puede activarse con solicitudes como:

- Investiga este ticket FDC.
- Continúa el análisis del 428.
- Compara este resultado con el handoff anterior.
- Ayúdame a preparar la validación UAT.
- Determina si el problema pertenece a Data, App/API o al cliente.

## Estructura

- SKILL.md: comportamiento operativo y reglas de activación.
- references/: conocimiento técnico, gobierno, ownership y casos conocidos.
- assets/: plantillas de investigación y comunicación.
- evals/: escenarios que verifican el comportamiento esperado.
- source-material/: reservado para fuentes originales incorporadas sin alterar.

## Seguridad

La skill analiza y recomienda. No escribe en Jira, no ejecuta SQL, no promueve cambios y no modifica sistemas salvo autorización explícita separada del usuario.

## Estado

Versión 1.0.0. La base inicial contiene conocimiento consolidado; los archivos técnicos originales deben añadirse a source-material/ para ampliar la trazabilidad documental sin reescribir la metodología.
