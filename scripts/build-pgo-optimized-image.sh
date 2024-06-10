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
            -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
            -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
            -Ob \
            --gc=G1 \
            --enable-sbom=cyclonedx \
            -H:-MLProfileInference \
            -march:native \
            --pgo \
            -o ./target/searchbot-optimized

echo "What is the weather today?"
./target/searchbot-optimized "What is JavaDay Lviv"