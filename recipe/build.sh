#!/usr/bin/env bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./config

mkdir build
cd build

# NOTE: as of 3.6.7,
# - sndfile is used by dcmwave, which is not in the public repository
# - openjpeg is unused
cmake ${CMAKE_ARGS} \
    -G Ninja \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D BUILD_SHARED_LIBS:BOOL=TRUE \
    -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
    -D DCMTK_ENABLE_PRIVATE_TAGS:BOOL=TRUE \
    -D DCMTK_WITH_ICONV:BOOL=OFF \
    -D DCMTK_WITH_ICU:BOOL=OFF \
    -D DCMTK_WITH_OPENJPEG:BOOL=OFF \
    -D DCMTK_WITH_SNDFILE:BOOL=OFF \
    ..

cmake --build . --target install --parallel

