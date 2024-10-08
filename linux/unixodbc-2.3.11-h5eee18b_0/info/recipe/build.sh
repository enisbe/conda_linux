#!/bin/bash

set -e
set -x

export CFLAGS="-O2 ${CFLAGS}"
export CXXFLAGS="-O2 ${CXXFLAGS}"

autoreconf -vfi

if [[ ${target_platform} == osx-64 ]]; then
  export SDKROOT=${CONDA_BUILD_SYSROOT}
fi

./configure --prefix=${PREFIX}  \
            --build=${BUILD} \
            --enable-editline=yes \
            --sysconfdir=/etc

make -j${CPU_COUNT} ${VERBOSE_AT}
make install
