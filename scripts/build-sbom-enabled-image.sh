#!/bin/bash
native-image \
               -Ob \
               --enable-sbom=cyclonedx \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               -o ./target/searchbot-sbom-enabled