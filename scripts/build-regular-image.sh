#!/bin/bash
native-image \
               -Ob \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               -o ./target/searchbot