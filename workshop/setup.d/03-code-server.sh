#!/bin/bash
set -x
set +e

jq ". + { \"java.server.launchMode\": \"Standard\", \"redhat.telemetry.enabled\": false }" /home/eduk8s/.local/share/code-server/User/settings.json > /tmp/settings.json
mv /tmp/settings.json /home/eduk8s/.local/share/code-server/User/settings.json
