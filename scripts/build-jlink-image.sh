#!/bin/sh

rm -rf searchbot-jlink
jlink \
        --module-path ./target/searchbot-1.0-jar-with-dependencies.jar \
        --strip-debug \
        --compress zip-9 \
        --no-header-files \
        --no-man-pages \
        --strip-java-debug-attributes \
        --output ./target/searchbot-jlink

# Distroless Java Base-provides glibc and other libraries needed by the JDK
docker build . -f scripts/Dockerfile.distroless-java-base.jlink -t searchbot:distroless-java-base.jlink
