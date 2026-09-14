# Metodología de investigación

## 1. Encuadre

Registrar ticket, síntoma, ambiente, consumidor afectado, ventana temporal, impacto y expectativa funcional. Separar lo reportado por el usuario de lo observado directamente.

## 2. Recuperación

Buscar primero materiales ya disponibles. Crear una tabla de evidencia con fuente, fecha, ambiente, observación, confianza y vigencia. No volver a ejecutar una prueba si el resultado anterior todavía responde la pregunta.

## 3. Mapa mínimo

Representar cada frontera con:

| Capa | Objeto/proceso | Grano | Identidad | Tiempo | Esperado | Observado |
|---|---|---|---|---|---|---|

La primera fila donde esperado y observado divergen define dónde profundizar.

## 4. Pruebas discriminantes

Elegir la siguiente prueba según cuánto reduce incertidumbre. Ejemplos:

- ¿El nuevo UID existe antes de Accordia?
- ¿La fila está en la vista dinámica pero no en el espejo?
- ¿Cambió el grano entre origen y destino?
- ¿El segundo run con el mismo input crea otra identidad?
- ¿La diferencia aparece sólo después de Mobile sync?

Cada prueba debe indicar qué rama sigue con YES y con NO.

## 5. Causalidad

Para declarar RCA, demostrar:

1. El mecanismo existe en código/configuración activa.
2. El mecanismo fue ejecutado en la ruta del caso.
3. Su salida coincide con la desviación observada.
4. No hay una explicación alternativa de igual o mayor fuerza.
5. Una validación controlada puede demostrar que el fix elimina el síntoma.

Si no, usar CURRENT BEST MECHANISM.

## 6. Soluciones

Separar:

- Mitigation: reduce impacto inmediato.
- Recovery: recupera operación o datos.
- Immediate fix: corrige el mecanismo del ticket.
- Cleanup: clasifica y repara historia.
- Stabilization: elimina la clase de defectos.
- Monitoring: detecta recurrencia o degradación.

No mezclar cleanup con prevención. Primero detener nueva corrupción.

## 7. Validación

Toda validación debe declarar baseline, acción, resultado esperado, resultado real y evidencia. Incluir retry, replay, input repetido, 0/1/>1 candidatos, run parcial, run fallido y consumidores downstream cuando apliquen.

## 8. Cierre

Cerrar técnicamente cuando haya causa demostrada, alcance conocido, fix verificable, riesgos cubiertos y dueño del siguiente paso. El estado Jira puede diferir del estado técnico.
