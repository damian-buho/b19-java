<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology,common-misspellings -->

[English](../../README.md) · [Українська](../uk/README.md)

# B19 / Java

Distribución de Java mantenida por la comunidad, construida sobre B19/Ubuntu. Este repositorio contiene únicamente el empaquetado — Dockerfile, scripts de compilación y configuración, todo con licencia MIT; el código original de Java se obtiene en tiempo de compilación y conserva su propia licencia.

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![Projectfile inside](https://badges.kiota.ch/static/v1?label=projectfile&message=inside&labelColor=0d0d0d&color=8c6723&style=flat-square)](https://projectfile.org) [![License](https://badges.kiota.ch/static/v1?label=license&message=MIT&color=1e5913&style=flat-square)](LICENSE) [![PRs welcome](https://badges.kiota.ch/static/v1?label=PRs&message=welcome&color=1e5913&style=flat-square)](CONTRIBUTING.md) [![REUSE compliance](https://api.reuse.software/badge/github.com/damian-buho/b19-java)](https://api.reuse.software/info/github.com/damian-buho/b19-java)

![Project status](https://badges.kiota.ch/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit on GitHub](https://badges.kiota.ch/github/last-commit/damian-buho/b19-java?label=last%20commit%20on%20GitHub&style=flat-square)](https://github.com/damian-buho/b19-java) [![Last commit on kiota.ch](https://badges.kiota.ch/gitea/last-commit/b19/java?gitea_url=https://kiota.ch&label=last%20commit%20on%20kiota.ch&style=flat-square)](https://kiota.ch/b19/java)

[![Publish pipeline on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/published.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Vulnerability audit on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/audited.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Dependency freshness on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Analysis sweep on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/analyze.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions)

[![Publish pipeline on kiota.ch](https://kiota.ch/b19/java/badges/workflows/published.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Vulnerability audit on kiota.ch](https://kiota.ch/b19/java/badges/workflows/audited.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Dependency freshness on kiota.ch](https://kiota.ch/b19/java/badges/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Analysis sweep on kiota.ch](https://kiota.ch/b19/java/badges/workflows/analyze.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions)

## Características

- Importación de certificados CA en runtime
- JDK desde el tarball upstream con elección de distribución
- Métricas Prometheus opcionales vía JMX
- Flags de JVM ajustados a producción

También hereda las características de B19 / Ubuntu; consulta [Características](FEATURES.md) para ver la lista completa.

## Qué entrega este proyecto

- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:oracle-21`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:oracle-25`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:oracle-26`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:oracle-27`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:temurin-21`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:temurin-25`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:temurin-26`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java:temurin-27`
- **Imagen de contenedor** `damianbuho/b19-java:oracle-21`
- **Imagen de contenedor** `damianbuho/b19-java:oracle-25`
- **Imagen de contenedor** `damianbuho/b19-java:oracle-26`
- **Imagen de contenedor** `damianbuho/b19-java:oracle-27`
- **Imagen de contenedor** `damianbuho/b19-java:temurin-21`
- **Imagen de contenedor** `damianbuho/b19-java:temurin-25`
- **Imagen de contenedor** `damianbuho/b19-java:temurin-26`
- **Imagen de contenedor** `damianbuho/b19-java:temurin-27`

## Instalación

Descarga la imagen de contenedor publicada:

### Descargar de GHCR — linux/amd64

```sh
docker pull ghcr.io/damian-buho/b19/java:oracle-21
```

### Descargar de DockerHub — linux/amd64

```sh
docker pull damianbuho/b19-java:oracle-21
```

Distribución: `oracle` | `temurin`

Serie: `21` | `25` | `26` | `27`

Las versiones estables también publican las etiquetas `X.Y.Z`, `X.Y` y `X`: descarga el nivel de precisión que quieras fijar.

Si los registros anteriores no están disponibles, descarga desde el origen:

### Descargar de Kiota — linux/amd64

```sh
docker pull kiota.ch/b19/java:oracle-21
```

Distribución: `oracle` | `temurin`

Serie: `21` | `25` | `26` | `27`

## Uso

Construye sobre esta imagen:

### Desde GHCR

```dockerfile
FROM ghcr.io/damian-buho/b19/java:oracle-21
```

### Desde DockerHub

```dockerfile
FROM damianbuho/b19-java:oracle-21
```

Distribución: `oracle` | `temurin`

Serie: `21` | `25` | `26` | `27`

Para el patrón multietapa recomendado y el sistema de hooks de compilación (build.d), genera un derivado con `b19/scripts/scaffold.sh` de [m6e/b19](https://kiota.ch/m6e/b19).

## Compilación

Clona el repositorio con sus submódulos:

```sh
git clone --recurse-submodules https://github.com/damian-buho/b19-java java && cd java
```

Construye la imagen de contenedor en local:

```sh
make container-build
```

- [Referencia del Makefile](../how-to/MAKEFILE.md)

Ejecuta `make` sin argumentos para el destino predeterminado; ejecuta `make help` para listar todos los destinos.

Para el bucle de desarrollo local, `make dev-container` levanta el dev-container.

Puntos de entrada de la canalización:

- `make analyze` — Ejecuta el análisis pesado (pruebas de mutación, benchmarks)
- `make audited` — Vuelve a escanear las dependencias fijadas y los artefactos publicados en busca de vulnerabilidades nuevas
- `make check-outdated` — Informa de cada dependencia fijada que va por detrás de su versión upstream
- `make ready-to-publish` — Ejecuta localmente el pipeline pseudo-CI — compila, prueba y escanea, sin publicar

## Políticas

- [Cómo contribuir](CONTRIBUTING.md)
- [Política de seguridad](SECURITY.md)
- [Cómo obtener ayuda](SUPPORT.md)
- [Código de conducta](CODE_OF_CONDUCT.md)
- [Política sobre IA y LLM](AI_POLICY.md)

## Enlaces

- [Especificación de Projectfile](https://projectfile.org)

## Licencia

Este proyecto se publica bajo la licencia MIT — consulta el archivo [LICENSE](LICENSE) para más detalles.

<!-- textlint-enable -->
