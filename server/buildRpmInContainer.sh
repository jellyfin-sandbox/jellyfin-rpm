#!/bin/bash

set -exu

HOME="$(pwd)"
SOURCE_DIR="$(pwd)/jellyfin-code"
RPMBUILD_HOME="$(pwd)/rpmbuild"
MANUAL_PROVIDED_DEPENDENCIES="true"
export HOME
export SOURCE_DIR
export RPMBUILD_HOME
export MANUAL_PROVIDED_DEPENDENCIES

mkdir rpmbuild

pushd jellyfin-code

# build rpm
make -f fedora/Makefile srpm outdir="${RPMBUILD_HOME}/SRPMS"
rpmbuild -rb "${RPMBUILD_HOME}"/SRPMS/jellyfin-*.src.rpm

popd

# move the artifacts
mkdir out
mv "${RPMBUILD_HOME}"/RPMS/x86_64/jellyfin-*.rpm "${RPMBUILD_HOME}"/SRPMS/jellyfin-*.src.rpm out
