#!/bin/bash
set -x
set +e

cd $HOME/exercises

echo "#@data/values" > ./values.yaml
echo "---" >> ./values.yaml
pathEnv=".image_prefix"  valueEnv=$( echo "${REGISTRY_HOST}/" ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
