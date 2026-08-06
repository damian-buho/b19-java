#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  M6E_SERIES="${B19_JAVA_SERIES}"
  export M6E_SERIES
  eval "$(b19-resolve-dep "java/${B19_JAVA_DISTRO}" "${TARGETARCH}")"

  b19-fetch "JAVA" "${M6E_UPSTREAM__URL}" "${M6E_UPSTREAM__FILE}" "${M6E_UPSTREAM__HASH}"

  b19-run "JAVA" "$(_p "Extract %s" "${B19_TEMP_PATH}/${M6E_UPSTREAM__FILE}")" --     \
    tar --directory "${B19_PREFIX}"                                                   \
        --extract                                                                     \
        --file "${B19_TEMP_PATH}/${M6E_UPSTREAM__FILE}"                               \
        --strip-components 1                                                          \
        --use-compress-program pigz

  b19-run "JAVA" "$(_ "Remove Java source archive")" --  rm -f "${B19_PREFIX}/lib/src.zip"
  b19-run "JAVA" "$(_ "Remove jmods (jlink modules)")" --  rm -rf "${B19_PREFIX}/jmods"
