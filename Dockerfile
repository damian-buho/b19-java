# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

ARG B19_UBUNTU_BASE_IMAGE=registry.invalid/b19/ubuntu:resolute

FROM ${B19_UBUNTU_BASE_IMAGE} AS b19-java

ARG B19_JAVA_DISTRO=oracle
ARG B19_JAVA_SERIES=25
ARG B19_PREFIX=/usr/local
ARG B19_COLOR
ARG B19_FETCH_DOCKER_CACHE
ARG B19_FETCH_LOCAL_CACHE
ARG B19_OFFGRID_MODE
ARG B19_VERBOSITY
ARG LANG=""
ARG M6E_AI=N
ARG M6E_APT_CACHE_HOST=""
ARG M6E_APT_CACHE_PORT=""
ARG M6E_DEV_MODE=N
ARG M6E_NAMESPACE
ARG M6E_NEAR_CACHE_HOST=""
ARG M6E_PROJECT
ARG M6E_VERSION
ARG TARGETARCH

ENV B19_JAVA_DISTRO="${B19_JAVA_DISTRO}"      \
    B19_JAVA_JMX_CONFIG="${B19_HOME}/jmx-exporter/config.yaml" \
    B19_JAVA_JMX_ENABLED=false                  \
    B19_JAVA_JMX_HOST=127.0.0.1                 \
    B19_JAVA_JMX_PORT=9404                      \
    B19_JAVA_SERIES="${B19_JAVA_SERIES}"      \
    B19_JAVA_XMS=512m                         \
    B19_JAVA_XMX=2048m


USER 0

WORKDIR ${B19_HOME}

# Copy dependencies, entrypoint, healthcheck and build scripts
COPY --chown=${B19_UID}:${B19_GID} .container/base/ /

# Build Stage 1 (root)

RUN --mount=type=bind,from=fetch,source=.,target=/fetch                                             \
    --mount=type=cache,id=apt-cache-${B19_UBUNTU_SERIES}-${TARGETARCH},target=/var/cache/apt,sharing=shared       \
    --mount=type=cache,id=apt-lists-${B19_UBUNTU_SERIES}-${TARGETARCH},target=/var/lib/apt,sharing=shared         \
    --mount=type=cache,target=${B19_DOWNLOAD_PATH},sharing=shared,uid=${B19_UID},gid=${B19_GID}     \
    --mount=type=tmpfs,target=${B19_TEMP_PATH}                                                      \
    build-stage base

# hadolint ignore=DL3066 # B19_UID comes from the root
USER ${B19_UID}

COPY --chown=${B19_UID}:${B19_GID} .container/user/ /

RUN --mount=type=bind,from=fetch,source=.,target=/fetch                                             \
    --mount=type=cache,target=${B19_DOWNLOAD_PATH},sharing=shared,uid=${B19_UID},gid=${B19_GID}     \
    --mount=type=tmpfs,target=${B19_TEMP_PATH}                                                      \
    build-stage user

# ENTRYPOINT ["entrypoint.d"] is inherited
# HEALTHCHECK CMD ["healthcheck.d"] is inherited
# Don't use CMD ["sleep", "infinity"] here
