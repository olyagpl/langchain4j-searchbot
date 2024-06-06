#!/bin/sh
TOOLCHAIN_DIR=`pwd`/x86_64-linux-musl-native
CC=${TOOLCHAIN_DIR}/bin/gcc
PATH=${TOOLCHAIN_DIR}/bin:${PATH}
native-image \
               -Ob \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               --static --libc=musl \
               -o ./target/searchbot.static

# Scratch-nothing
docker build . -f scripts/Dockerfile.scratch.static -t searchbot:scratch.static

# Distroless Static-no glibc
docker build . -f scripts/Dockerfile.distroless-static.static -t searchbot:distroless-static.static

# Alpine-no glibc
docker build . -f scripts/Dockerfile.alpine.static -t searchbot:alpine.static

# Compress with UPX
rm -f searchbot.static-upx
../upx --lzma --best -o target/searchbot.static-upx target/searchbot.static

# Scratch--fully static and compressed
docker build . -f scripts/Dockerfile.scratch.static-upx -t searchbot:scratch.static-upx