<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# b19/Java

Docker image built on [b19/Ubuntu](../ubuntu/AGENTS.md)

JDK runtime image with 2D axis: distribution x series. Base for scala, and used by f5m/i2p, d9t/java-tools, o9s/keycloak.

## Key facts

- Base: `b19/ubuntu:${B19_UBUNTU_SERIES}` (resolute) — single stage
- 2D axis: `B19_JAVA_DISTRO` (oracle, temurin) x `B19_JAVA_SERIES` (21, 25, 26, 27)
- Image name: `b19/java:{distro}-{series}` (e.g. `b19/java:oracle-25`, `b19/java:temurin-21`)
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
- `jmods/` kept: only Temurin 24+ can `jlink` from its runtime image (JEP 493); Oracle (every series) and Temurin 21 fail without `jmods/`
- CDS: `-XX:+UseZGC` (our `vm.options`) maps `classes_nocoops.jsa`, the default G1 maps `classes.jsa`; only the two `_coh` archives (compact object headers, never enabled here) are deleted
- Slim runtime export: `build.d/export/post/100-export-java.i.sh` runs on `build-stage export` in any `FROM b19/java` stage (as root) and writes a `jlink` runtime to `/export/usr/local`, plus the Java runtime hooks, `vm.options.j2`, the version test and a generated `entrypoint.d/0900-set-java-defaults.sh` (`ENV` does not cross a `COPY`; it sets each `B19_JAVA_*` value only when unset, before `1000-parallel-j2` renders `vm.options`). [How-to](docs/how-to/use-export.md)
- The export hook unpacks every jar into one class tree and deletes `module-info.class` and `META-INF` before `jdeps`: a modular jar whose `requires` are bundled into other jars (I2P’s Jetty and Tomcat) fails `jdeps` outright, `--ignore-missing-deps` and `--module-path` included. Unpacking uses `env --chdir`, because Java 21’s `jar` has no `--dir`
- `java.logging` is in the default export set because the JDK’s default CDS class list preloads it; without it the CDS dump prints a warning per class
- The exported runtime has no `javac`, `jar` or `jdeps`, so `test.d/1200` and `1300` stay in this image only
- Runtime CA import: `entrypoint.d/1100-add-certs-to-java.i.sh` — seeds `${B19_HOME}/lib/security/cacerts` from the system truststore, imports each `${B19_HOME}/ca-certs/*.pem` via `keytool`, and points Java at the copy (no rebuild required)
- Opt-in Prometheus metrics: `entrypoint.d/1160-enable-jmx-exporter.i.sh` — attaches the Prometheus JMX exporter javaagent (pinned jar under `${B19_HOME}/jmx-exporter/`, default JVM-only config) via `JAVA_TOOL_OPTIONS` when `B19_JAVA_JMX_ENABLED=true`, so every `java` invocation (including Tanuki-wrapped downstream JVMs) exposes `/metrics`. Disabled by default, loopback bind by default

## ENV

- `B19_JAVA_DISTRO=oracle`
- `B19_JAVA_EXPORT_ENABLED=true`, `B19_JAVA_EXPORT_JMX=false`, `B19_JAVA_EXPORT_PATH=${B19_HOME}`, `B19_JAVA_EXPORT_MODULES` (build-time, never exported)
- `B19_JAVA_JMX_CONFIG=${B19_HOME}/jmx-exporter/config.yaml`
- `B19_JAVA_JMX_ENABLED=false`
- `B19_JAVA_JMX_HOST=127.0.0.1`
- `B19_JAVA_JMX_PORT=9404`
- `B19_JAVA_XMS=512m`
- `B19_JAVA_XMX=2048m`

## Documentation

- [Available make targets](@docs/MAKEFILE.md)
- [Known caveats and limitations](@docs/caveats.md)
- [Completed features](@docs/done.md)
- [Project fit and alignment](@docs/fit.md)
- [Project goals](@docs/goal.md)
- [Future roadmap](@docs/roadmap.md)
