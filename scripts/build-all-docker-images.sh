#!/bin/sh 

./scripts/build-dynamic-image.sh
./scripts/build-mostly-static-image.sh
./scripts/build-static-image.sh
./scripts/build-jlink-image.sh

echo "Generated Executables"
ls -lh target/searchbot*

echo "Generated Docker Container Images"
docker images searchbot
