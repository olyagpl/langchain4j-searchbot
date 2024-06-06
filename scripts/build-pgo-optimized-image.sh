#!/bin/bash
native-image \
               -Ob \
               --pgo-instrument \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               -o ./target/searchbot-instrumented

echo "What is the weather today?"
./target/searchbot-instrumented "What is the weather today?"
echo "-----------------------------------------------------"
native-image \
               -Ob \
               --pgo \
               -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
               -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
               -o ./target/searchbot-optimized

echo "What is the weather today?"
./target/searchbot-optimized "What is JavaDay Lviv"