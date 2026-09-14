# Ambientes, permisos y escalamiento

Los permisos cambian con el tiempo. Nunca asumir que DEV, UAT o PROD comparten roles, objetos, credenciales o capacidad de ejecución.

## Registro por investigación

| Campo | Valor |
|---|---|
| Ambiente del síntoma | UNKNOWN |
| Ambiente de reproducción | UNKNOWN |
| Ambiente del código inspeccionado | UNKNOWN |
| Rol de lectura | UNKNOWN |
| Rol de desarrollo | UNKNOWN |
| Quién ejecuta | UNKNOWN |
| Quién promueve | UNKNOWN |
| Quién valida | UNKNOWN |
| Ventana autorizada | UNKNOWN |
| Ruta de escalamiento | UNKNOWN |

Completar sólo con evidencia vigente.

## Guardrails

- Verificar database, schema, warehouse, role y branch antes de interpretar resultados.
- No extrapolar DEV a UAT o PROD sin comparar configuración y datos.
- No entregar una acción de ejecución a alguien sin confirmar ownership.
- No asumir que acceso de lectura implica permiso de modificación.
- Separar quien desarrolla, ejecuta, promueve, valida y aprueba.
- Tratar fallos de permisos como dependencia, no como invitación a evadir controles.
- Para ventanas operacionales, registrar UTC y zona local con fecha para controlar DST.

## Escalamiento

Escalar cuando:

- se requiere una decisión funcional;
- el objeto pertenece a otro equipo;
- falta un tester o consumidor especializado;
- el siguiente paso requiere permisos no disponibles;
- existe riesgo de pérdida, cleanup masivo o impacto downstream;
- la evidencia difiere entre ambientes.

La solicitud de escalamiento debe incluir hallazgo confirmado, impacto, acción concreta requerida, owner por rol, ambiente y ventana.
