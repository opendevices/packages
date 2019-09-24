#!/bin/bash

#
# Copyright (2019) Open Devices
# Copyright (2019) Djalal Harouni
#

COMMAND=${0##*/}

usage() {
        echo "
release=\"version\" stable=\"true\" $COMMAND'
" >&2
        exit 2
}

declare VERSION=""
declare STABLE=""

declare latest_stable="releases/latest-stable"
declare latest_beta="releases/latest-beta"
declare MANAGER_PATH=""
declare SUPPORTED_ARCHS="arm6 arm7 amd64"
declare -a MANAGERS_PATHS


# For Uploading sealos manager lets continue to use github
# *DO NOT USE our servers unless you ask a maintainer*
declare download_url="https://raw.githubusercontent.com/opendevices/packages/master/sealos-manager/"

get_manager_path() {
        ver=$VERSION
        arch=$1
        MANAGER_PATH=$(find ./ -name "*$ver*${arch}*zip" -print)
}

patch_latest_file() {
        file=$1
        echo -n "$VERSION" > $file
}

main() {
        if [ -z ${RELEASE} ]; then
                VERSION=${release}
        else
                VERSION=${RELEASE}
        fi

        if [ -z "${STABLE}" ]; then
                STABLE=${stable}
        fi

        if [ -z ${VERSION} ]; then
                # read release version from latest-files
                echo "Release: release environment var is not set, reading from latest-files"
                if [ "$stable" != "true" ]; then
                        VERSION=$(cat $latest_beta)
                else
                        VERSION=$(cat $latest_stable)
                fi
        fi

        for arch in $SUPPORTED_ARCHS
        do
                echo
                echo "Release manager: looking for $arch release $VERSION"
                get_manager_path $arch

                if [ ! -z "$MANAGER_PATH" ]; then
                        MANAGER_PATH="${MANAGER_PATH:2}"
                        echo "Release: found $MANAGER_PATH"
                        git add $MANAGER_PATH
                        MANAGERS_PATHS+=($MANAGER_PATH)

                        if [ "$STABLE" != "true" ]; then
                                echo "Release: writing url 'beta' ${download_url}${MANAGER_PATH}"
                                echo -n "${download_url}${MANAGER_PATH}" > "releases/sealos-manager-latest-beta-$arch.link"
                        else
                                echo "Release: writing url 'stable' ${download_url}${MANAGER_PATH}"
                                echo -n "${download_url}${MANAGER_PATH}" > "releases/sealos-manager-latest-$arch.link"
                        fi
                else
                        echo "Release: Error: could not find manager version $VERSION arch $arch"
                fi
        done

        # delaying patching
        if [ "$STABLE" != "true" ]; then
                BRANCH="beta"
                patch_latest_file $latest_beta
        else
                BRANCH="stable"
                patch_latest_file $latest_stable
        fi

        echo
        git commit -s -m "manager:release: update branch '$BRANCH' release files" -a

        echo
        git push -u origin master

        export BRANCH=$BRANCH
        export VERSION=$VERSION
        export FILES=${MANAGERS_PATHS[@]}
        ./deploy_sealos_manager.bash
}

main
