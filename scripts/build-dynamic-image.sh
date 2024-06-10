#!/bin/sh
# Compile with all dynamically linked shared libraries
native-image \
               -Os \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               -o ./target/searchbot.dynamic

# Distroless Java Base-provides glibc and other libraries needed by the JDK
docker build . -f scripts/Dockerfile.distroless-java-base.dynamic -t searchbot:distroless-java-base.dynamic