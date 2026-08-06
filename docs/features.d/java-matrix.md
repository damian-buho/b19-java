<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Two-dimensional build matrix (distribution x series)

- CI builds every combination of distribution (`oracle`, `temurin`) and JDK series (`21`, `25`, `26`) as a declarative matrix, declared in `projectfile.yaml`.
- Each cell produces a separate image: `b19/java/{distro}-{series}` (e.g., `b19/java/oracle-25`, `b19/java/temurin-21`).
- Both amd64 and arm64 architectures are built for every matrix cell.
- Matrix axes are portable CI declarations, not hardcoded Makefile knobs -- the same definition lowers to GitHub Actions, Forgejo, and Tekton.
