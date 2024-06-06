#!/bin/sh
native-image \
               -Ob \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               -H:+UnlockExperimentalVMOptions -H:+StaticExecutableWithDynamicLibC \
               -o ./target/searchbot.mostly

# Distroless Base (provides glibc)
docker build . -f scripts/Dockerfile.distroless-base.mostly -t searchbot:distroless-base.mostly
