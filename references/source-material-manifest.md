# Manifiesto de fuentes

## Estado del repositorio en 1.0.0

El repositorio se creó inicialmente sólo con README.md. Los archivos técnicos mencionados durante la investigación previa no estaban físicamente disponibles al construir este commit.

Por ello:

- No se inventó ni reconstruyó su contenido.
- Los hechos consolidados se documentaron como conocimiento derivado.
- La trazabilidad a línea exacta debe revalidarse cuando se incorporen las fuentes originales.
- source-material/ queda reservado para copias originales sin alterar.

## Fuentes mencionadas y no incorporadas

Entre las fuentes conocidas aparecen:

- downtime-process-maps.html
- fdc_downtime_mrg.json
- Usp_Delete_OldDwntmRecords
- Usp_Inactivate_OldDwntmRecords
- modelos stg_pre_upsert de Downtime
- modelos de DOWNTIME_MASTER y DOWNTIME_EXCEPTIONS
- manifiestos y jobs de orquestación
- handoffs históricos de FDCSD-428, 458 y 459
- código AssetMetricsViewModel relacionado con versionado

Esta lista no afirma nombres exactos ni contenido completo fuera de lo ya consolidado.

## Incorporación

Cuando se agreguen archivos:

1. Guardarlos bajo source-material/<dominio>/ sin alterar.
2. Añadir SHA o referencia de commit.
3. Actualizar el inventario.
4. Vincular hechos derivados.
5. Revalidar known-cases.md.
6. Ejecutar evals/evaluation-cases.yaml.
