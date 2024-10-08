#!/bin/bash

cd ${SRC_DIR}

# to fix configure version mismatch
autoreconf

./configure --prefix=${PREFIX}  \
            --host=${HOST}      \
            --build=${BUILD}
make -j${CPU_COUNT} ${VERBOSE_AT}

if [[ $(uname) != Darwin ]]; then
  make check
  make tests
fi

make install
