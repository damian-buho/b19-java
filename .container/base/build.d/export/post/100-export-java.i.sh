#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  if [ "${B19_JAVA_EXPORT_ENABLED}" != "true" ]; then
    b19-log info "JAVA" "$(_p "Java runtime export disabled (B19_JAVA_EXPORT_ENABLED=%s)" "${B19_JAVA_EXPORT_ENABLED}")"
    return 0
  fi

  JAVA_EXPORT_RUNTIME="${B19_TEMP_PATH}/java-runtime"
  JAVA_EXPORT_JAR_LIST=()
  JAVA_EXPORT_WANTED="${B19_JAVA_EXPORT_MODULES}"

  # Jars under B19_JAVA_EXPORT_PATH; the JMX exporter joins only on request
  if [ -n "${B19_JAVA_EXPORT_PATH}" ]; then
    mapfile -t JAVA_EXPORT_JAR_LIST < <(fd --hidden --no-ignore --type file --extension jar --exclude jmx-exporter . "${B19_JAVA_EXPORT_PATH}")
  fi
  if [ "${B19_JAVA_EXPORT_JMX}" = "true" ]; then
    JAVA_EXPORT_JAR_LIST+=("${B19_HOME}/jmx-exporter/jmx_prometheus_javaagent.jar")
  fi
  b19-log info "JAVA" "$(_p "Scanning %s jars under %s for modules" "${#JAVA_EXPORT_JAR_LIST[@]}" "${B19_JAVA_EXPORT_PATH}")"

  if [ "${#JAVA_EXPORT_JAR_LIST[@]}" -gt 0 ]; then
    if JAVA_EXPORT_FOUND="$(jdeps --ignore-missing-deps --multi-release "${B19_JAVA_SERIES}" --print-module-deps "${JAVA_EXPORT_JAR_LIST[@]}")"; then
      b19-log info "JAVA" "$(_p "jdeps found modules: %s" "${JAVA_EXPORT_FOUND}")"
    else
      JAVA_EXPORT_FOUND="java.se"
      b19-log warn "JAVA" "$(_p "jdeps failed, falling back to %s" "${JAVA_EXPORT_FOUND}")"
    fi
    JAVA_EXPORT_WANTED="${JAVA_EXPORT_WANTED},${JAVA_EXPORT_FOUND}"
  fi

  # Keep only modules this JDK has, so one default list serves every series
  JAVA_EXPORT_AVAILABLE="$(java --list-modules | sed 's/@.*//')"
  JAVA_EXPORT_MODULE_LIST=""
  while IFS= read -r JAVA_EXPORT_MODULE; do
    if grep --quiet --fixed-strings --line-regexp "${JAVA_EXPORT_MODULE}" <<<"${JAVA_EXPORT_AVAILABLE}"; then
      JAVA_EXPORT_MODULE_LIST="${JAVA_EXPORT_MODULE_LIST:+${JAVA_EXPORT_MODULE_LIST},}${JAVA_EXPORT_MODULE}"
    else
      b19-log info "JAVA" "$(_p "Module %s not in Java %s, skipped" "${JAVA_EXPORT_MODULE}" "${B19_JAVA_SERIES}")"
    fi
  done < <(tr ',' '\n' <<<"${JAVA_EXPORT_WANTED}" | sed '/^$/d' | sort --unique)

  b19-run "JAVA" "$(_p "Link Java runtime with %s" "${JAVA_EXPORT_MODULE_LIST}")" --   \
    jlink --add-modules "${JAVA_EXPORT_MODULE_LIST}"                                 \
          --generate-cds-archive                                                     \
          --no-header-files                                                          \
          --no-man-pages                                                             \
          --output "${JAVA_EXPORT_RUNTIME}"                                          \
          --strip-java-debug-attributes

  b19-run "JAVA" "$(_p "Create %s" "/export${B19_PREFIX}")" -- mkdir --parents "/export${B19_PREFIX}"
  b19-run "JAVA" "$(_p "Export Java runtime to %s" "/export${B19_PREFIX}")" -- cp --archive "${JAVA_EXPORT_RUNTIME}/." "/export${B19_PREFIX}/"

  # Runtime hooks, JVM flags template and version test, taken from where the builder already has them
  JAVA_EXPORT_FILE_LIST=(
    "/command.d/get-java-version"
    "/deps/java/${B19_JAVA_DISTRO}/${B19_JAVA_SERIES}/version.deps"
    "${B19_ENTRYPOINT_PATH}/1100-add-certs-to-java.i.sh"
    "${B19_ENTRYPOINT_PATH}/1150-apply-vmoptions.i.sh"
    "${B19_ENTRYPOINT_PATH}/1160-enable-jmx-exporter.i.sh"
    "${B19_HOME}/vm.options.j2"
    "${B19_TEST_PATH}/1000-check-java-version.sh"
  )
  if [ "${B19_JAVA_EXPORT_JMX}" = "true" ]; then
    JAVA_EXPORT_FILE_LIST+=("${B19_HOME}/jmx-exporter")
  fi
  for JAVA_EXPORT_FILE in "${JAVA_EXPORT_FILE_LIST[@]}"; do
    b19-run "JAVA" "$(_p "Export %s" "${JAVA_EXPORT_FILE}")" -- cp --archive --parents "${JAVA_EXPORT_FILE}" /export/
  done

  # ENV does not cross a COPY: ship the B19_JAVA_* defaults as an entrypoint hook that yields to any value already set
  JAVA_EXPORT_DEFAULTS="/export${B19_ENTRYPOINT_PATH}/0900-set-java-defaults.sh"
  printf '#!/usr/bin/env bash\n\n' > "${JAVA_EXPORT_DEFAULTS}"
  while IFS= read -r JAVA_EXPORT_NAME; do
    # shellcheck disable=SC2016 # the ${…+set} test is written into the hook, not expanded here
    printf '  [ -n "${%s+set}" ] || export %s=%q\n' "${JAVA_EXPORT_NAME}" "${JAVA_EXPORT_NAME}" "${!JAVA_EXPORT_NAME}" >> "${JAVA_EXPORT_DEFAULTS}"
    b19-log debug "JAVA" "$(_p "Default %s=%s" "${JAVA_EXPORT_NAME}" "${!JAVA_EXPORT_NAME}")"
  done < <(compgen -e | grep '^B19_JAVA_' | grep --invert-match '^B19_JAVA_EXPORT_' | sort)

  b19-log good "JAVA" "$(_p "Exported Java runtime: %s" "$(du --summarize --human-readable "${JAVA_EXPORT_RUNTIME}" | cut --fields 1)")"
