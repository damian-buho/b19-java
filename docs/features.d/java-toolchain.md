<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# JDK from upstream tarball with distribution choice

- JDK installed from upstream tarballs (not APT), pinned per distribution, series, and architecture with SHA-512 verification.
- Two distributions available: Oracle JDK (production-tested, OTN license) and Eclipse Temurin (fully open-source OpenJDK build).
- `src.zip` is stripped from the final image to reduce size; `jmods/` is kept, so the runtime image can `jlink`.
- Includes `git` for build tooling and dependency resolution.
