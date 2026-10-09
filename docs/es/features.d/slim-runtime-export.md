<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Entorno de ejecución Java reducido para imágenes de aplicación

- Una imagen de aplicación incluye solo los módulos de Java que usa en lugar de un JDK completo: sin compilador, cabeceras ni herramientas de desarrollo, por lo que pesa varios cientos de megabytes menos y expone menos superficie.
- El conjunto de módulos se deriva de los propios JAR de la aplicación, más un conjunto predeterminado para juegos de caracteres, configuraciones regionales y gestión; cada imagen puede sustituirlo o ampliarlo.
- El entorno reducido conserva lo que esta imagen añade al arrancar: flags de JVM de producción, importación de CA propias y la prueba de versión. El exportador JMX de Prometheus se incluye a petición.
- El arranque sigue siendo rápido: el entorno lleva su propio archivo de class-data sharing.
- Funciona con todas las distribuciones y series que publica esta imagen. Consulta [la guía](../how-to/use-export.md).

<!-- textlint-enable -->
