<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Importación de certificados CA en runtime

- Los archivos PEM colocados en `${B19_HOME}/ca-certs/` se importan al arrancar el contenedor en una copia escribible del truststore del sistema (`${B19_HOME}/lib/security/cacerts`), que contiene todas las raíces del sistema más el certificado importado.
- Java se apunta a la copia mediante `-Djavax.net.ssl.trustStore`, integrado en `JAVA_TOOL_OPTIONS`; las CA personalizadas surten efecto en cada invocación.
- No hace falta reconstruir la imagen: monta o copia los certificados en runtime.
- Cada certificado se importa con su nombre de archivo como alias y con el flag `trustcacerts` activado (contraseña del truststore del sistema `changeit`).
- El hook de importación es heredable, de modo que las imágenes derivadas construidas sobre `b19/java` obtienen el mismo comportamiento automáticamente.

<!-- textlint-enable -->
