<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Opt-in Prometheus metrics via JMX

- The Prometheus JMX exporter javaagent ships pinned in the image and attaches to every `java` invocation when `B19_JAVA_JMX_ENABLED=true`, exposing JVM metrics (heap, GC, threads) on a `/metrics` endpoint for Prometheus to scrape.
- Disabled by default and bound to loopback by default -- no port opens unless you ask, and the bind address, port, and config file are all runtime-overridable with no rebuild.
- The default config reports JVM metrics with no per-application setup; mount your own exporter config (or point `B19_JAVA_JMX_CONFIG` at it) to add application MBean rules.
- The hook is inheritable, so downstream images built on `b19/java` get the same behavior automatically.
