#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  if [ "${B19_JAVA_JMX_ENABLED:-false}" != "true" ]; then
    b19-log info "JMX" "$(_ "JMX exporter disabled (B19_JAVA_JMX_ENABLED=false)")"
    return 0
  fi

  JMX_JAR="${B19_HOME}/jmx-exporter/jmx_prometheus_javaagent.jar"
  JMX_CONFIG="${B19_JAVA_JMX_CONFIG:-${B19_HOME}/jmx-exporter/config.yaml}"
  JMX_PORT="${B19_JAVA_JMX_PORT:-9404}"
  JMX_HOST="${B19_JAVA_JMX_HOST:-127.0.0.1}"

  if [ ! -f "${JMX_JAR}" ]; then
    b19-log warn "JMX" "$(_p "JMX agent jar missing at %s -- metrics not exposed" "${JMX_JAR}")" >&2
    return 0
  fi

  if [ ! -f "${JMX_CONFIG}" ]; then
    b19-log warn "JMX" "$(_p "JMX config missing at %s -- metrics not exposed" "${JMX_CONFIG}")" >&2
    return 0
  fi

  # A non-numeric port would make the agent exit(1) the JVM on startup.
  if ! [[ "${JMX_PORT}" =~ ^[0-9]+$ ]]; then
    b19-log warn "JMX" "$(_p "JMX port not numeric: %s -- metrics not exposed" "${JMX_PORT}")" >&2
    return 0
  fi

  export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:+${JAVA_TOOL_OPTIONS} }-javaagent:${JMX_JAR}=${JMX_HOST}:${JMX_PORT}:${JMX_CONFIG}"
  b19-log info "JMX" "$(_p "JMX exporter attached on %s:%s" "${JMX_HOST}" "${JMX_PORT}")"
