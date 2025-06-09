#!/bin/bash
set -eux

TARGET="${1:-ledge-secure-qemuarm64}"
TYPE="${2:-baremetal}"
COMMAND="${3:-build}"

echo "Building EWAOL ${TYPE} for ${TARGET}"

KAS_BUILD_DIR="${KAS_BUILD_DIR:-${PWD}/build/${TARGET}}"
DL_DIR="${DL_DIR:-${HOME}/yocto_cache/download}"
SSTATE_DIR="${SSTATE_DIR:-${HOME}/yocto_cache/sstate}"

mkdir -p "${KAS_BUILD_DIR}"

KAS_BUILD_DIR="${KAS_BUILD_DIR}" \
    SSTATE_DIR="${SSTATE_DIR}" \
    DL_DIR="${DL_DIR}" \
    kas "${COMMAND}" "kas/ewaol/${TYPE}.yml:kas/machine/${TARGET}.yml"
