<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
-->

<!-- pf-cli-managed: yes -->
# B19/Java

JDK runtime with Oracle and Temurin distributions

[![License](https://img.shields.io/badge/license-MIT-4c1?style=flat-square)](LICENSE) [![PRs welcome](https://img.shields.io/badge/PRs-welcome-4c1?style=flat-square)](CONTRIBUTING.md) [![REUSE compliance](https://api.reuse.software/badge/codeberg.org/b19/java)](https://api.reuse.software/info/codeberg.org/b19/java)

![Project status](https://img.shields.io/badge/status-maintained-1d63ed?style=flat-square) [![Last commit](https://img.shields.io/gitea/last-commit/b19/java?gitea_url=https://codeberg.org&style=flat-square)](https://codeberg.org/b19/java)

[![Build status on kiota.ch](https://kiota.ch/b19/java/badges/workflows/published.yaml/badge.svg)](https://kiota.ch/b19/java/actions)

## Features

- Runtime CA certificate import
- Two-dimensional build matrix (distribution x series)
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

See [Features](FEATURES.md) for the full list.

## What this provides

- **Container image** `kiota.ch/b19/java/oracle-{B19_JAVA_SERIES}:latest`
- **Container image** `kiota.ch/b19/java/temurin-{B19_JAVA_SERIES}:latest`

## Installation

Pull the published container image:

```sh
docker pull kiota.ch/b19/java/oracle-{B19_JAVA_SERIES}:latest
docker pull kiota.ch/b19/java/temurin-{B19_JAVA_SERIES}:latest
```

## Usage

Build on top of this image:

```dockerfile
FROM kiota.ch/b19/java/oracle-{B19_JAVA_SERIES}:latest
FROM kiota.ch/b19/java/temurin-{B19_JAVA_SERIES}:latest
```

## Building

- [Makefile reference](docs/MAKEFILE.md)

Pipeline entry points:

- `make analyze` — Run the heavy analysis sweep (mutation testing, benchmarks)
- `make audited` — Re-scan the pinned dependencies and published artifacts for new vulnerabilities
- `make check-outdated` — Report every pinned dependency that lags upstream
- `make published` — Build, test, scan and publish the release artifacts

## Policies

- [How to contribute](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [Getting support](SUPPORT.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)

## Links

### Project

- [B19/Java on Codeberg](https://codeberg.org/b19/java)
- [B19/Java on GitHub](https://github.com/damian-buho/b19-java)
- [B19/Java on kiota.ch](https://kiota.ch/b19/java)
- [Issues on Codeberg](https://codeberg.org/b19/java/issues)
- [Issues on GitHub](https://github.com/damian-buho/b19-java/issues)

## License

This project is licensed under MIT — see the [LICENSE](LICENSE) file for details.
