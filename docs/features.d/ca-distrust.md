<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Compromised certificate authorities removed from the JDK truststore

- Oracle and Temurin each ship their own `cacerts`, apart from the system store; it is cut from the same b19 distrust list at build time, without waiting for a JDK update.
- Every listed fingerprint also joins the JDK blocklist, which rejects a compromised intermediate anywhere in a chain, cross-signed copies included.
- The slim `jlink` export is cut the same way, and a certificate imported at startup cannot bring a blocked intermediate back.
- `B19_CA_DISTRUST` adds fingerprints, and `B19_CA_DISTRUST_ENABLED=false` leaves the JDK store as shipped.
