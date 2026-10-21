<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# Autoridades de certificación comprometidas eliminadas del almacén de confianza del JDK

- Oracle y Temurin incluyen cada uno su propio `cacerts`, independiente del almacén del sistema; se recorta con la misma lista de desconfianza de b19 durante la construcción, sin esperar a una actualización del JDK.
- Cada huella listada se añade también a la lista de bloqueo del JDK, que rechaza un intermedio comprometido en cualquier punto de la cadena, incluidas sus copias con firma cruzada.
- La exportación reducida con `jlink` se recorta igual, y un certificado importado al arrancar no puede devolver un intermedio bloqueado.
- `B19_CA_DISTRUST` añade huellas, y `B19_CA_DISTRUST_ENABLED=false` deja el almacén del JDK tal como se distribuye.

<!-- textlint-enable -->
