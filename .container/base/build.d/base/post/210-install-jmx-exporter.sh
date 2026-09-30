#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  eval "$(b19-resolve-dep "jmx-exporter")"

  b19-fetch "JMX" "${M6E_UPSTREAM__URL}" "${M6E_UPSTREAM__FILE}" "${M6E_UPSTREAM__HASH}"

  JMX_DIR="${B19_HOME}/jmx-exporter"
  b19-run "JMX" "$(_p "Install JMX exporter %s" "${M6E_UPSTREAM_VERSION}")" --   \
    mkdir -p "${JMX_DIR}" &&                                                    \
    cp "${B19_TEMP_PATH}/${M6E_UPSTREAM__FILE}" "${JMX_DIR}/jmx_prometheus_javaagent.jar"
