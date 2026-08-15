<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

<!-- textlint-disable terminology -->

[English](../../README.md) · [Українська](../uk/README.md)

# B19/Java

JDK runtime with Oracle and Temurin distributions

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![License](https://img.shields.io/static/v1?label=license&message=MIT&color=4c1&style=flat-square)](LICENSE) ![Commit style](https://img.shields.io/static/v1?label=commits&message=conventional&color=blue&style=flat-square) ![Workflow](https://img.shields.io/static/v1?label=workflow&message=git-flow&color=blue&style=flat-square) ![Versioning](https://img.shields.io/static/v1?label=versioning&message=semantic&color=blue&style=flat-square) [![PRs welcome](https://img.shields.io/static/v1?label=PRs&message=welcome&color=4c1&style=flat-square)](CONTRIBUTING.md) [![Citation](https://img.shields.io/static/v1?label=citation&message=cff&color=blue&style=flat-square)](CITATION.cff) [![REUSE compliance](https://api.reuse.software/badge/codeberg.org/b19/java)](https://api.reuse.software/info/codeberg.org/b19/java)

![Project status](https://img.shields.io/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit](https://img.shields.io/gitea/last-commit/b19/java?gitea_url=https://codeberg.org&style=flat-square)](https://codeberg.org/b19/java)

[![Build status on kiota.ch](https://kiota.ch/b19/java/badges/workflows/published.yaml/badge.svg)](https://kiota.ch/b19/java/actions)

## Características

- Runtime CA certificate import
- JDK from upstream tarball with distribution choice
- Production-tuned JVM flags
- Persistent APT cache across builds
- Service process management with log routing (b19-exec)
- Cached artifact downloads with integrity verification (b19-fetch)
- Timed command execution with failure reporting (b19-run)
- Run-once initialization (bootstrap.d)
- Modular build hooks (build.d)
- Automatic CPU count detection (NUMPROCS)
- Declarative dependency management (b19-deps)
- Pluggable startup system (entrypoint.d)
- Feature toggles for all subsystems
- Built-in health monitoring (healthcheck.d)
- Multilingual shell output (b19-i18n)
- Image lineage tracking
- Structured, level-filtered logging (b19-log)
- Non-root container by default
- Air-gapped / offline build and runtime support
- Runtime overlay injection
- Reproducible base image (pinned by digest)
- Port validation
- Unified lifecycle runner family
- Docker secrets auto-loading (secrets)
- Interactive shell hooks (shell.d)
- Graceful signal handling
- Jinja2 configuration templates (minijinja-cli)
- Built-in test framework (test.d)
- Pre-installed utility tools
- XDG Base Directory paths

Consulta [FEATURES.md](../../FEATURES.md) para ver la lista completa.

## Qué entrega este proyecto

- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java/oracle-21:latest`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java/oracle-25:latest`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java/oracle-26:latest`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java/temurin-21:latest`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java/temurin-25:latest`
- **Imagen de contenedor** `ghcr.io/damian-buho/b19/java/temurin-26:latest`
- **Imagen de contenedor** `docker.io/damianbuho/b19-java-oracle-21:latest`
- **Imagen de contenedor** `docker.io/damianbuho/b19-java-oracle-25:latest`
- **Imagen de contenedor** `docker.io/damianbuho/b19-java-oracle-26:latest`
- **Imagen de contenedor** `docker.io/damianbuho/b19-java-temurin-21:latest`
- **Imagen de contenedor** `docker.io/damianbuho/b19-java-temurin-25:latest`
- **Imagen de contenedor** `docker.io/damianbuho/b19-java-temurin-26:latest`

## Instalación

Descarga la imagen de contenedor publicada:

```sh
docker pull ghcr.io/damian-buho/b19/java/oracle-21:latest
```

Variantes disponibles: B19_JAVA_DISTRO: oracle, temurin · B19_JAVA_SERIES: 21, 25, 26

```sh
docker pull ghcr.io/damian-buho/b19/java/oracle-25:latest
docker pull ghcr.io/damian-buho/b19/java/oracle-26:latest
docker pull ghcr.io/damian-buho/b19/java/temurin-21:latest
docker pull ghcr.io/damian-buho/b19/java/temurin-25:latest
docker pull ghcr.io/damian-buho/b19/java/temurin-26:latest
docker pull docker.io/damianbuho/b19-java-oracle-21:latest
docker pull docker.io/damianbuho/b19-java-oracle-25:latest
docker pull docker.io/damianbuho/b19-java-oracle-26:latest
docker pull docker.io/damianbuho/b19-java-temurin-21:latest
docker pull docker.io/damianbuho/b19-java-temurin-25:latest
docker pull docker.io/damianbuho/b19-java-temurin-26:latest
```

Si los registros anteriores no están disponibles, descarga desde el origen:

```sh
docker pull kiota.ch/b19/java/oracle-21:latest
```

Variantes disponibles: B19_JAVA_DISTRO: oracle, temurin · B19_JAVA_SERIES: 21, 25, 26

```sh
docker pull kiota.ch/b19/java/oracle-25:latest
docker pull kiota.ch/b19/java/oracle-26:latest
docker pull kiota.ch/b19/java/temurin-21:latest
docker pull kiota.ch/b19/java/temurin-25:latest
docker pull kiota.ch/b19/java/temurin-26:latest
```

## Uso

Construye sobre esta imagen:

```dockerfile
FROM ghcr.io/damian-buho/b19/java/oracle-21:latest
```

Variantes disponibles: B19_JAVA_DISTRO: oracle, temurin · B19_JAVA_SERIES: 21, 25, 26

```dockerfile
FROM ghcr.io/damian-buho/b19/java/oracle-25:latest
FROM ghcr.io/damian-buho/b19/java/oracle-26:latest
FROM ghcr.io/damian-buho/b19/java/temurin-21:latest
FROM ghcr.io/damian-buho/b19/java/temurin-25:latest
FROM ghcr.io/damian-buho/b19/java/temurin-26:latest
FROM docker.io/damianbuho/b19-java-oracle-21:latest
FROM docker.io/damianbuho/b19-java-oracle-25:latest
FROM docker.io/damianbuho/b19-java-oracle-26:latest
FROM docker.io/damianbuho/b19-java-temurin-21:latest
FROM docker.io/damianbuho/b19-java-temurin-25:latest
FROM docker.io/damianbuho/b19-java-temurin-26:latest
```

Para el patrón multietapa recomendado y el sistema de hooks de compilación (build.d), genera un derivado con `b19/scripts/scaffold.sh` de [m6e/b19](https://kiota.ch/m6e/b19).

## Compilación

- [Referencia del Makefile](../MAKEFILE.md)

Puntos de entrada de la canalización:

- `make analyze` — Run the heavy analysis sweep (mutation testing, benchmarks)
- `make audited` — Re-scan the pinned dependencies and published artifacts for new vulnerabilities
- `make check-outdated` — Report every pinned dependency that lags upstream
- `make ready-to-publish` — Run the pseudo-CI pipeline locally — build, test and scan, without publishing

Ejecuta `make` sin argumentos para el destino predeterminado; ejecuta `make help` para listar todos los destinos.

Para el bucle de desarrollo local, `make dev-container` levanta el dev-container.

## Políticas

- [Cómo contribuir](CONTRIBUTING.md)
- [Política de seguridad](SECURITY.md)
- [Cómo obtener ayuda](SUPPORT.md)
- [Código de conducta](CODE_OF_CONDUCT.md)

## Enlaces

- [Especificación de Projectfile](https://projectfile.org)
- [B19/Java on Codeberg](https://codeberg.org/b19/java)
- [B19/Java on GitHub](https://github.com/damian-buho/b19-java)
- [B19/Java on kiota.ch](https://kiota.ch/b19/java)
- [Issues on Codeberg](https://codeberg.org/b19/java/issues)
- [Issues on GitHub](https://github.com/damian-buho/b19-java/issues)

## Licencia

Este proyecto se publica bajo la licencia MIT — consulta el archivo [LICENSE](LICENSE) para más detalles.

*Generado desde projectfile ([saber cómo](https://projectfile.org/how-to/readme))*
<!-- textlint-enable -->
