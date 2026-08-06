<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# JDK from upstream tarball with distribution choice

- JDK installed from upstream tarballs (not APT), pinned per distribution, series, and architecture with SHA-512 verification.
- Two distributions available: Oracle JDK (production-tested, OTN license) and Eclipse Temurin (fully open-source OpenJDK build).
- `jmods/` and `src.zip` are stripped from the final image to reduce size.
- Includes `git` for build tooling and dependency resolution.
