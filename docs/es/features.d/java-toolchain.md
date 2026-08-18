<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

<!-- textlint-disable terminology,common-misspellings -->

# JDK desde el tarball upstream con elección de distribución

- El JDK se instala desde tarballs upstream (no APT), fijado por distribución, serie y arquitectura con verificación SHA-512.
- Dos distribuciones disponibles: Oracle JDK (probado en producción, licencia OTN) y Eclipse Temurin (compilación totalmente open-source de OpenJDK).
- `jmods/` y `src.zip` se eliminan de la imagen final para reducir el tamaño.
- Incluye `git` para las herramientas de compilación y la resolución de dependencias.

<!-- textlint-enable -->
