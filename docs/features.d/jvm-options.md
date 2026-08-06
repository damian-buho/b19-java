<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Production-tuned JVM flags

- A `${B19_HOME}/vm.options` @-file is rendered from `vm.options.j2` at every container startup and flattened into `JAVA_TOOL_OPTIONS`, so every `java` invocation receives the flags automatically (the launcher reads `JAVA_TOOL_OPTIONS` before command-line args; an explicit `java -Xmx8g` still wins).
- The @-file is also available for explicit use (`java @${B19_HOME}/vm.options`).
- Flags included: ZGC (generational by default since JDK 21), string deduplication, compressed oops, escape analysis, parallel reference processing, string concatenation optimization, AlwaysPreTouch.
- Heap floor/ceiling are parameterized by `B19_JAVA_XMS` (default `512m`) and `B19_JAVA_XMX` (default `2048m`), interpolated into the template at render time -- no rebuild needed.
- Set `JAVA_TOOL_OPTIONS` explicitly to override the auto-applied flags entirely.
