<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# b19/Java

Docker image built on [b19/Ubuntu](../ubuntu/AGENTS.md)

JDK runtime image with 2D axis: distribution x series. Base for scala, and used by f5m/i2p, d9t/java-tools, o9s/keycloak.

## Key facts

- Base: `b19/ubuntu/${B19_UBUNTU_SERIES}` (resolute) — single stage
- 2D axis: `B19_JAVA_DISTRO` (oracle, temurin) x `B19_JAVA_SERIES` (21, 25, 26, 27)
- Image name: `b19/java/{distro}-{series}` (e.g. `b19/java/oracle-25`, `b19/java/temurin-21`)
- Arch: amd64, arm64
- BOTH axes need their own `--build-arg` line in the Makefile. An axis that is not forwarded falls back to the Dockerfile `ARG` default, so the cell builds the wrong JDK under the right tag — the image lies, and only `test.d` catches it
- Temurin splits `version.deps` (SemVer) from `build.deps` (build number): the upstream URL spells that number `%2B<build>` in the release tag and `_<build>` in the filename, so one variable cannot render both. Oracle carries no build number. MUST NOT re-pin a per-series `url.deps` — it shadows the distro template (`b19-resolve-dep` takes the most specific file) and then a version bump changes the filename without changing what is downloaded
- Oracle numbers releases `$FEATURE.$INTERIM.$UPDATE.$PATCH` and drops trailing zeros, so a patch release grows a fourth component (`21.0.12.1`) while Temurin always has three. Anything reading the version out of `java --version` MUST match a bare major plus every dotted component (`\d+(?:\.\d+)*`), skipping the `Picked up JAVA_TOOL_OPTIONS` notice and taking the first match on the first version line; a dotted-pair-only pattern exits 1 on the bare-major GA output (`27`), and `-m1` alone still prints the date too and `test.d/1000-check-java-version.sh` only fails on the next Oracle patch bump, one bump after the pattern was written

## Distributions

| Distro           | Source             | License  | Notes                                                  |
| ---------------- | ------------------ | -------- | ------------------------------------------------------ |
| oracle (default) | Oracle JDK tarball | OTN      | Production-tested, ships with Oracle-specific features |
| temurin          | Eclipse Adoptium   | GPLv2+CE | Most popular OpenJDK build, fully open-source          |

## What it provides

- Production JVM flags via `JAVA_TOOL_OPTIONS`: `${B19_HOME}/vm.options` is rendered at startup and flattened into `JAVA_TOOL_OPTIONS` so every `java` invocation gets them (entrypoint `1150-apply-vmoptions.i.sh`)
- ZGC generational mode, string deduplication, compressed oops by default
- `jmods/` stripped from final image (size reduction)
- Runtime CA import: `entrypoint.d/1100-add-certs-to-java.i.sh` — seeds `${B19_HOME}/lib/security/cacerts` from the system truststore, imports each `${B19_HOME}/ca-certs/*.pem` via `keytool`, and points Java at the copy (no rebuild required)

## ENV

- `B19_JAVA_DISTRO=oracle`
- `B19_JAVA_XMS=512m`
- `B19_JAVA_XMX=2048m`

## Documentation

- [Available make targets](@docs/MAKEFILE.md)
- [Known caveats and limitations](@docs/caveats.md)
- [Completed features](@docs/done.md)
- [Project fit and alignment](@docs/fit.md)
- [Project goals](@docs/goal.md)
- [Future roadmap](@docs/roadmap.md)
