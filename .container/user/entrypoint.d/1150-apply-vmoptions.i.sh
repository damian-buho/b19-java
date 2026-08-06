#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  # Apply the production JVM flags to EVERY java invocation. The @-file at
  # ${B19_HOME}/vm.options is rendered by 1000-parallel-j2 from vm.options.j2;
  # we flatten it into JAVA_TOOL_OPTIONS, which the JVM launcher reads
  # automatically (explicit `java -Xmx8g` still wins). When 1100-add-certs
  # built a custom truststore (B19_JAVA_TRUSTSTORE), fold its -D pointers in so
  # the imported CAs take effect. An existing JAVA_TOOL_OPTIONS (user override)
  # is never clobbered.
  OPTS_FILE="${B19_HOME}/vm.options"

  if [ -f "${OPTS_FILE}" ]; then
    FLAGS="$(tr '\n' ' ' < "${OPTS_FILE}" | sed -e 's/  */ /g' -e 's/^ //' -e 's/ $//')"
    if [ -n "${B19_JAVA_TRUSTSTORE:-}" ]; then
      FLAGS="${FLAGS} -Djavax.net.ssl.trustStore=${B19_JAVA_TRUSTSTORE} -Djavax.net.ssl.trustStorePassword=changeit"
    fi
    if [ -n "${JAVA_TOOL_OPTIONS:-}" ]; then
      b19-log info "JAVA" "$(_p "Preserving existing JAVA_TOOL_OPTIONS: %s" "${JAVA_TOOL_OPTIONS}")"
    else
      export JAVA_TOOL_OPTIONS="${FLAGS}"
      b19-log info "JAVA" "$(_p "JVM flags applied via JAVA_TOOL_OPTIONS from %s" "${OPTS_FILE}")"
    fi
  else
    b19-log warn "JAVA" "$(_p "vm.options missing at %s -- JVM flags not applied" "${OPTS_FILE}")" >&2
  fi
