<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Slim Java runtime for application images

- An application image ships only the Java modules it uses instead of a full JDK: no compiler, headers or developer tools, so it is several hundred megabytes smaller and exposes less.
- The module set is derived from the application’s own jars, plus a default set for character sets, locales and management; each image can replace or extend it.
- The slim runtime keeps what this image adds at startup: production JVM flags, custom CA import and the version test. The Prometheus JMX exporter is included on request.
- Startup stays fast: the runtime carries its own class-data sharing archive.
- Works for every distribution and series this image publishes. See [the how-to](../how-to/use-export.md).
