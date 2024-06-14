#!/bin/bash
native-image \
            -Os \
            -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
            -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
            -H:+UnlockExperimentalVMOptions -H:+BuildReport \
            -o ./target/searchbot-optimized

echo "What is the weather today?"
./target/searchbot-optimized "What is JavaDay Lviv"