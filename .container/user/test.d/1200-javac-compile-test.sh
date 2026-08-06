#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  TESTDIR=$(mktemp -d)

  JAVA_VERSION=$(java -version 2>&1 | head -n1 | grep -oP '\d+\.\d+' | head -1)

  cat > "${TESTDIR}/HelloWorld.java" << 'EOF'
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("ok");
  }
}
EOF

  javac -J-Xms64m -J-Xmx128m "${TESTDIR}/HelloWorld.java"
  java -Xms64m -Xmx128m -cp "${TESTDIR}" HelloWorld
  b19-log good "JAVA" "$(_p "javac-%s compile test passed" "${JAVA_VERSION}")"

  rm -rf "${TESTDIR}"
