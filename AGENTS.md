# Instrucciones para agentes

## Propósito del repositorio

Mantener una skill operativa para investigaciones FDC. El archivo SKILL.md contiene el contrato de ejecución; references/ contiene conocimiento modular; source-material/ conserva evidencia original.

## Antes de cambiar conocimiento

1. Leer SKILL.md y la referencia del dominio.
2. Confirmar si la fuente original ya existe.
3. Separar evidencia, interpretación e hipótesis.
4. Verificar fecha, ambiente, versión y vigencia.
5. Detectar contradicciones y reglas reemplazadas.
6. Excluir secretos y PII innecesaria.

## Reglas de edición

- Mantener SKILL.md compacto y orientado a comportamiento.
- No copiar fuentes extensas dentro de SKILL.md.
- No reescribir archivos bajo source-material/.
- Añadir conocimiento derivado a references/.
- Actualizar source-material-manifest.md y CHANGELOG.md.
- Añadir o ajustar una evaluación por cada guardrail nuevo.
- No borrar historia válida; marcarla historical, superseded o contradicted.
- No afirmar cobertura documental que no exista físicamente en el repositorio.

## Validación mínima

- Frontmatter de SKILL.md con name y description.
- Todas las rutas citadas por SKILL.md existen.
- Las evaluaciones cubren el cambio.
- No hay secretos, tokens ni datos personales innecesarios.
- Los casos conocidos distinguen hechos de inferencias.
- Los límites de solo lectura siguen vigentes.

## Operación

No usar este repositorio como autorización para escribir en Jira, ejecutar SQL, desplegar, promover o modificar infraestructura. Cada acción externa requiere una solicitud explícita separada del usuario.
