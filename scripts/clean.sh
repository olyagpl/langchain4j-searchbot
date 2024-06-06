#!/bin/sh

set +e

rm -rf searchbot-jlink/
rm ./target/searchbot.dynamic ./target/searchbot.mostly ./target/searchbot.static ./target/searchbot.static-upx
rm -rf svm*.md
docker images searchbot -q | grep -v TAG | awk '{print($1)}' | xargs docker rmi