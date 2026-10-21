#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  FAILED=0
  LIST="$(b19-ca-distrust list)"
  BLOCKED="${B19_PREFIX}/lib/security/blocked.certs"

  while IFS= read -r PRINT; do
    if ! grep --quiet --fixed-strings --line-regexp "${PRINT}" "${BLOCKED}"; then
      b19-log error "JAVA" "$(_p "%s missing from %s" "${PRINT}" "${BLOCKED}")"
      FAILED=$((FAILED + 1))
    fi
  done <<<"${LIST}"

  while IFS= read -r LINE; do
    PRINT="$(tr --delete ':' <<<"${LINE##*SHA256: }")"
    if grep --quiet --fixed-strings --line-regexp "${PRINT}" <<<"${LIST}"; then
      b19-log error "JAVA" "$(_p "Truststore still trusts %s" "${PRINT}")"
      FAILED=$((FAILED + 1))
    fi
  done < <(keytool -J-Duser.language=en -list -v -cacerts -storepass changeit | grep --fixed-strings 'SHA256: ')

  [ "${FAILED}" -eq 0 ] || exit 1
  b19-log good "JAVA" "$(_p "%s distrusted fingerprints blocked and absent from the truststore" "$(wc --lines <<<"${LIST}")")"
