<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Métricas Prometheus opcionales vía JMX

- El javaagent del exportador JMX de Prometheus viene fijado en la imagen y se adjunta a cada invocación de `java` cuando `B19_JAVA_JMX_ENABLED=true`, exponiendo métricas de la JVM (heap, GC, hilos) en un endpoint `/metrics` para que Prometheus las recolecte.
- Deshabilitado por defecto y ligado a loopback por defecto -- ningún puerto se abre salvo que lo pidas, y la dirección, el puerto y el archivo de configuración se ajustan en tiempo de ejecución sin recompilar.
- La configuración por defecto reporta métricas de la JVM sin preparación por aplicación; monta tu propia configuración del exportador (o apunta `B19_JAVA_JMX_CONFIG` a ella) para agregar reglas de MBeans de aplicación.
- El hook es heredable, así las imágenes derivadas de `b19/java` obtienen el mismo comportamiento automáticamente.

<!-- textlint-enable -->
