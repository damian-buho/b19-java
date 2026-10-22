#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  # The temp mount can be a noexec tmpfs, so the runtime is built where it can run
  RUNTIME_DIR="$(mktemp -d -p "${B19_HOME}")"
  trap 'rm -rf "${RUNTIME_DIR}"' EXIT

  jlink -J-Xms64m -J-Xmx256m --add-modules java.base --output "${RUNTIME_DIR}/runtime"
  "${RUNTIME_DIR}/runtime/bin/java" -Xms64m -Xmx128m -version
  b19-log good "JAVA" "$(_p "jlink runtime for Java %s starts" "${B19_JAVA_SERIES}")"
