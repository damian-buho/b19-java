#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  rm -rf /tmp/jlink-runtime-test
  jlink -J-Xms64m -J-Xmx256m --add-modules java.base --output /tmp/jlink-runtime-test
  /tmp/jlink-runtime-test/bin/java -Xms64m -Xmx128m -version
  b19-log good "JAVA" "$(_p "jlink runtime for Java %s starts" "${B19_JAVA_SERIES}")"

  rm -rf /tmp/jlink-runtime-test
