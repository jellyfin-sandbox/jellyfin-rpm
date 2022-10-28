#!/bin/bash

set -exu

HOME="$(pwd)"
SOURCE_DIR="$(pwd)/jellyfin-web"
RPMBUILD_HOME="$(pwd)/rpmbuild"
export HOME
export SOURCE_DIR
export RPMBUILD_HOME

mkdir rpmbuild

pushd jellyfin-web

# build rpm
make -f fedora/Makefile srpm outdir="${RPMBUILD_HOME}/SRPMS"
rpmbuild -rb "${RPMBUILD_HOME}/SRPMS/jellyfin-*.src.rpm"

popd

# move the artifacts
mkdir out
mv "${RPMBUILD_HOME}/RPMS/noarch/jellyfin-*.rpm" "${RPMBUILD_HOME}/SRPMS/jellyfin-*.src.rpm" out
