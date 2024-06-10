#!/bin/bash
native-image \
            -Os \
            -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
            -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
            -o ./target/searchbot-optimized

echo "What is the weather today?"
./target/searchbot-optimized "What is JavaDay Lviv"