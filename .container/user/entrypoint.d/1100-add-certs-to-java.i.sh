#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  # Import user-supplied PEM files into a writable copy of the system Java
  # truststore, then export B19_JAVA_TRUSTSTORE so 1150-apply-vmoptions points
  # every java invocation at it. The system cacerts at
  # ${B19_PREFIX}/lib/security is root-owned (uid 1000 cannot write it in
  # place), so we derive a user-writable copy under ${B19_HOME} that carries
  # every system root plus the imported certificate.
  CERTS_DIR="${B19_HOME}/ca-certs"
  SYS_CACERTS="${B19_PREFIX}/lib/security/cacerts"

  if [ -d "${CERTS_DIR}" ] && compgen -G "${CERTS_DIR}/*.pem" > /dev/null && [ -r "${SYS_CACERTS}" ]; then
    USER_CACERTS="${B19_HOME}/lib/security/cacerts"
    mkdir -p "$(dirname "${USER_CACERTS}")"

    # Seed the writable copy from the system truststore (fresh roots per start).
    b19-run "CERTS" "$(_p "Seed truststore from %s" "${SYS_CACERTS}")" --     \
      cp "${SYS_CACERTS}" "${USER_CACERTS}"

    for cert in "${CERTS_DIR}"/*.pem; do
      [ -e "$cert" ] || continue
      cert_alias="$(basename "$cert" .pem)"
      b19-run "CERTS" "$(_p "Import %s as alias %s" "$cert" "${cert_alias}")" --      \
        keytool                                                                       \
          -alias "${cert_alias}"                                                      \
          -file "$cert"                                                               \
          -importcert                                                                 \
          -keystore "${USER_CACERTS}"                                                 \
          -storepass changeit                                                         \
          -noprompt                                                                   \
          -trustcacerts || true
    done

    export B19_JAVA_TRUSTSTORE="${USER_CACERTS}"
    b19-log info "CERTS" "$(_p "Custom truststore active: %s" "${USER_CACERTS}")"
  else
    b19-log info "CERTS" "$(_p "No CA certificates in %s -- using system truststore" "${CERTS_DIR}")" >&2
  fi
