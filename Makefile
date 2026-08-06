# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

# M6E MAKEFILE T3

B19_JAVA_DISTRO  ?= oracle
B19_JAVA_SERIES  ?= 25

M6E_CONTAINER_NAME = $(subst /,-,${NAMESPACE})-${PROJECT}-$(B19_JAVA_DISTRO)-$(B19_JAVA_SERIES)
M6E_IMAGE_BASENAME = ${NAMESPACE}/${PROJECT}/$(B19_JAVA_DISTRO)-$(B19_JAVA_SERIES)

# Both matrix axes must reach the build: the cell binds them as make command-line
# vars, and a bare --build-arg NAME makes buildx read that value from the env. A
# missing one silently falls back to the Dockerfile ARG default.
M6E_DOCKER_BUILDX_OPTIONS += --build-arg B19_JAVA_DISTRO
M6E_DOCKER_BUILDX_OPTIONS += --build-arg B19_JAVA_SERIES
M6E_DOCKER_BUILDX_OPTIONS += --build-arg M6E_DEV_MODE=$(M6E_DEV_MODE)

# Rules

# Includes

all: .makefile/core/initialize.mk

.makefile/core/initialize.mk:
	git submodule update --init --recursive
	$(MAKE) bootstrap

-include .makefile/core/initialize.mk
