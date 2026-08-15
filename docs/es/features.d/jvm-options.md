<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Flags de JVM ajustados a producción

- Un @-file `${B19_HOME}/vm.options` se genera a partir de `vm.options.j2` en cada arranque del contenedor y se integra en `JAVA_TOOL_OPTIONS`, de modo que cada invocación de `java` recibe los flags automáticamente (el launcher lee `JAVA_TOOL_OPTIONS` antes que los argumentos de la línea de comandos; un `java -Xmx8g` explícito sigue ganando).
- El @-file también está disponible para uso explícito (`java @${B19_HOME}/vm.options`).
- Flags incluidos: ZGC (generacional por defecto desde JDK 21), deduplicación de cadenas, compressed oops, escape analysis, procesamiento paralelo de referencias, optimización de la concatenación de cadenas, AlwaysPreTouch.
- El suelo y el techo del heap se parametrizan con `B19_JAVA_XMS` (por defecto `512m`) y `B19_JAVA_XMX` (por defecto `2048m`), interpolados en la plantilla al renderizar; no hace falta recompilar.
- Establece `JAVA_TOOL_OPTIONS` explícitamente para sobrescribir por completo los flags aplicados automáticamente.
