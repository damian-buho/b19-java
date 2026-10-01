#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  JMX_JAR="${B19_HOME}/jmx-exporter/jmx_prometheus_javaagent.jar"
  JMX_CONFIG="${B19_HOME}/jmx-exporter/config.yaml"
  JMX_TEST_PORT=19404

  [ -f "${JMX_JAR}" ] || { echo "FATAL: JMX agent jar missing at ${JMX_JAR}" >&2; exit 1; }
  [ -f "${JMX_CONFIG}" ] || { echo "FATAL: JMX config missing at ${JMX_CONFIG}" >&2; exit 1; }

  TESTDIR=$(mktemp -d)

  cat > "${TESTDIR}/Sleeper.java" << 'EOF'
public class Sleeper {
  public static void main(String[] args) throws Exception {
    Thread.sleep(60000);
  }
}
EOF

  javac -J-Xms64m -J-Xmx128m -d "${TESTDIR}" "${TESTDIR}/Sleeper.java"

  # Probe the agent on a test port with a clean environment, so a container
  # running with B19_JAVA_JMX_ENABLED=true does not double-attach its own agent.
  env -u JAVA_TOOL_OPTIONS java -Xms64m -Xmx128m \
    "-javaagent:${JMX_JAR}=127.0.0.1:${JMX_TEST_PORT}:${JMX_CONFIG}" \
    -cp "${TESTDIR}" Sleeper &
  JMX_PID=$!

  METRICS=""
  for _try in $(seq 1 30); do
    METRICS="$(curl -sSL --max-time 5 "http://127.0.0.1:${JMX_TEST_PORT}/metrics" || true)"
    [ -n "${METRICS}" ] && break
    sleep 1
  done

  kill "${JMX_PID}" 2>/dev/null || true
  wait "${JMX_PID}" 2>/dev/null || true

  grep -q "^jvm_" <<<"${METRICS}" || { echo "FATAL: no jvm_ metrics on :${JMX_TEST_PORT}/metrics" >&2; exit 1; }
  b19-log good "JMX" "$(_p "JMX exporter scrape test passed on port %s" "${JMX_TEST_PORT}")"

  rm -rf "${TESTDIR}"
