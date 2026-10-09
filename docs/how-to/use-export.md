<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Ship a slim Java runtime

An application that only runs Java does not need the full JDK at runtime. This image can build a runtime with only the modules your application uses and hand it to an image built on B19/Ubuntu, in the same way other B19 builders hand over their output through `/export`.

## Dockerfile

Use two stages. The builder is `FROM` this image, installs the application and runs the `export` build stage as root. The final stage is `FROM` B19/Ubuntu and copies `/export` over its root.

```dockerfile
ARG B19_JAVA_IMAGE=registry.invalid/b19/java:temurin-26
ARG B19_UBUNTU_BASE_IMAGE=registry.invalid/b19/ubuntu:resolute

FROM ${B19_JAVA_IMAGE} AS app-builder
# … install the application under ${B19_HOME} …
COPY .container/export/ /
USER 0
RUN --mount=type=tmpfs,target=${B19_TEMP_PATH} build-stage export

FROM ${B19_UBUNTU_BASE_IMAGE} AS app
COPY --from=app-builder /export/ /
# … build-stage root (apt packages), then build-stage user …
```

- Run `build-stage user` in the final stage: it renders the exported `vm.options.j2` and registers the exported test.
- Install apt packages in the final stage. The builder’s packages stay behind.
- Copy the application into `/export` with your own hook in `build.d/export/post/`, numbered after `100` (for example `500-export-app.sh`), using `cp --archive --parents` so ownership survives.

## What lands in `/export`

- The linked runtime under `/usr/local`, with `java`, `keytool` and its own class-data sharing archive.
- The startup hooks for production JVM flags, custom CA import and the JMX exporter, plus `vm.options.j2`.
- The Java version test and `get-java-version`.
- `entrypoint.d/0900-set-java-defaults.sh`, which sets every `B19_JAVA_*` default of this image unless the final image already sets it. An `ENV` in the final stage therefore still wins.

## Settings

| Variable                  | Default                           | Effect                                                             |
| ------------------------- | --------------------------------- | ------------------------------------------------------------------ |
| `B19_JAVA_EXPORT_ENABLED` | `true`                            | `false` skips the Java export.                                     |
| `B19_JAVA_EXPORT_PATH`    | `${B19_HOME}`                     | Directory whose jars decide the modules. Empty skips the scan.     |
| `B19_JAVA_EXPORT_MODULES` | `java.logging`, `jdk.charsets`, … | Modules always linked. With an empty path, this is the whole list. |
| `B19_JAVA_EXPORT_JMX`     | `false`                           | `true` adds the Prometheus JMX exporter and the modules it needs.  |

Modules that a series does not have are skipped, so one list serves every series.

## Limits

- The runtime has no `javac`, `jar` or other JDK tools. A script that calls one must find another way, such as `unzip` for a jar manifest.
- The module scan cannot see into `.war` files or follow reflection. Add what it misses to `B19_JAVA_EXPORT_MODULES`, and let your image’s tests run on the slim runtime to prove the set.
