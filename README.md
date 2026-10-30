<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
SPDX-License-Identifier: MIT
pf-cli-managed: yes
-->

[Español](docs/es/README.md) · [Українська](docs/uk/README.md)

# B19 / Java

Oracle and Temurin JDKs in series 25 and 27, with ZGC enabled, slim jlink runtimes for downstream images, and optional JMX metrics.

[![Stand with Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://damian-buho.github.io/support-ukraine/) [![Projectfile inside](https://badges.kiota.ch/static/v1?label=projectfile&message=inside&labelColor=0d0d0d&color=8c6723&style=flat-square)](https://projectfile.org) [![License](https://badges.kiota.ch/static/v1?label=license&message=MIT&color=1e5913&style=flat-square)](LICENSE) [![PRs welcome](https://badges.kiota.ch/static/v1?label=PRs&message=welcome&color=1e5913&style=flat-square)](CONTRIBUTING.md) [![REUSE compliance](https://api.reuse.software/badge/github.com/damian-buho/b19-java)](https://api.reuse.software/info/github.com/damian-buho/b19-java)

![Project status](https://badges.kiota.ch/static/v1?label=status&message=maintained&color=1d63ed&style=flat-square) [![Last commit on GitHub](https://badges.kiota.ch/github/last-commit/damian-buho/b19-java?label=last%20commit%20on%20GitHub&style=flat-square)](https://github.com/damian-buho/b19-java) [![Last commit on kiota.ch](https://badges.kiota.ch/gitea/last-commit/b19/java?gitea_url=https://kiota.ch&label=last%20commit%20on%20kiota.ch&style=flat-square)](https://kiota.ch/b19/java)

[![Publish pipeline on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/published.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Vulnerability audit on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/audited.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Dependency freshness on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions) [![Analysis sweep on GitHub](https://github.com/damian-buho/b19-java/actions/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://github.com/damian-buho/b19-java/actions)

[![Publish pipeline on kiota.ch](https://kiota.ch/b19/java/badges/workflows/published.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Vulnerability audit on kiota.ch](https://kiota.ch/b19/java/badges/workflows/audited.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Dependency freshness on kiota.ch](https://kiota.ch/b19/java/badges/workflows/check-outdated.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions) [![Analysis sweep on kiota.ch](https://kiota.ch/b19/java/badges/workflows/analyzed.yaml/badge.svg?style=flat-square)](https://kiota.ch/b19/java/actions)

## Upstream

This project packages [Eclipse Temurin](https://adoptium.net) (`GPL-2.0-only WITH Classpath-exception-2.0`).
Thanks to: Eclipse Adoptium

This project packages [Oracle JDK](https://www.oracle.com/java/) (its own license).
Thanks to: Oracle

This project packages [Prometheus JMX Exporter](https://github.com/prometheus/jmx_exporter) (`Apache-2.0`).
Thanks to: Doug Hoard and Fabian Stäber (maintainers), Brian Brazil (original author)

## Features

- Runtime CA certificate import
- Compromised certificate authorities removed from the JDK truststore
- JDK from upstream tarball with distribution choice
- Opt-in Prometheus metrics via JMX
- Production-tuned JVM flags
- Slim Java runtime for application images

It also inherits the features of B19 / Ubuntu — see [Features](docs/FEATURES.md) for the full list.

## What this provides

- **Container image** `ghcr.io/damian-buho/b19/java:oracle-25`
- **Container image** `ghcr.io/damian-buho/b19/java:oracle-27`
- **Container image** `ghcr.io/damian-buho/b19/java:temurin-25`
- **Container image** `ghcr.io/damian-buho/b19/java:temurin-27`
- **Container image** `damianbuho/b19-java:oracle-25`
- **Container image** `damianbuho/b19-java:oracle-27`
- **Container image** `damianbuho/b19-java:temurin-25`
- **Container image** `damianbuho/b19-java:temurin-27`

## Installation

Pull the published container image:

### Pull from GHCR — linux/amd64, linux/arm64, linux/riscv64

```sh
docker pull ghcr.io/damian-buho/b19/java:oracle-25
```

### Pull from DockerHub — linux/amd64

```sh
docker pull damianbuho/b19-java:oracle-25
```

Distribution: `oracle` | `temurin`

Series: `25` | `27`

Stable releases also publish `X.Y.Z`, `X.Y` and `X` tags — pull the precision you want to pin.

If the registries above are unreachable, pull from the origin instead:

### Pull from Kiota — linux/amd64

```sh
docker pull kiota.ch/b19/java:oracle-25
```

Distribution: `oracle` | `temurin`

Series: `25` | `27`

## Usage

Build on top of this image:

### From GHCR

```dockerfile
FROM ghcr.io/damian-buho/b19/java:oracle-25
```

### From DockerHub

```dockerfile
FROM damianbuho/b19-java:oracle-25
```

Distribution: `oracle` | `temurin`

Series: `25` | `27`

For the recommended multi-stage pattern and the build-hook system (build.d), scaffold a derivative with `b19/scripts/scaffold.sh` from [m6e/b19](https://kiota.ch/m6e/b19).

## Building

Clone the repository with its submodules:

```sh
git clone --recurse-submodules https://github.com/damian-buho/b19-java java && cd java
```

Build the container image locally:

```sh
make container-build
```

- [Makefile reference](docs/how-to/MAKEFILE.md)

Run `make` with no arguments for the default target; run `make help` to list every target.

For the local dev loop, `make dev-container` brings up the dev-container.

Pipeline entry points:

- `make analyzed` — Run the heavy analysis sweep (mutation testing, benchmarks)
- `make audited` — Re-scan the pinned dependencies and published artifacts for new vulnerabilities
- `make check-outdated` — Report every pinned dependency that lags upstream
- `make release-is-ready` — Run the pseudo-CI pipeline locally — build, test and scan, without publishing

## Documentation

- [Ship a slim Java runtime](docs/how-to/use-export.md)

## Policies

- [How to contribute](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [Getting support](SUPPORT.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- [AI and LLM Policy](AI_POLICY.md)

## Links

- [Projectfile Specification](https://projectfile.org)

## License

The packaging in this repository is licensed under MIT — see the [LICENSE](LICENSE) file for details.
