<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Runtime CA certificate import

- PEM files placed in `${B19_HOME}/ca-certs/` are imported at container startup into a writable copy of the system truststore (`${B19_HOME}/lib/security/cacerts`), which carries every system root plus the imported certificate.
- Java is pointed at the copy via `-Djavax.net.ssl.trustStore`, folded into `JAVA_TOOL_OPTIONS` -- custom CAs take effect for every invocation.
- No image rebuild required -- mount or copy certificates at runtime.
- Each certificate is imported under its filename as alias, with `trustcacerts` flag set (system truststore password `changeit`).
- The import hook is inheritable, so downstream images built on `b19/java` get the same behavior automatically.
