#!/bin/bash
set -x
set +e

ROOT=$HOME/exercises

# Set up sample files
#     - clone repo
#     - copy files of interest to user $ROOT/intro directory
#     - replace hard-coded registry name with session registry
git clone https://github.com/ciberkleid/cartographer-concepts.git $ROOT/intro-temp
mkdir -p $ROOT/intro
mv $ROOT/intro-temp/layout-2/* $ROOT/intro
find ./intro -type f -not -path '*/\.*' -print0 | xargs -0 sed -i "s/harbor\.tanzu\.coraiberkleid\.site\/carto-demo/$REGISTRY_HOST/g"
rm -rf $ROOT/intro-temp

# Download cartographer repo examples
git clone https://github.com/vmware-tanzu/cartographer.git $ROOT/examples-temp
mkdir -p $ROOT/examples
mv $ROOT/examples-temp/examples/gitwriter-sc $ROOT/examples
mv $ROOT/examples-temp/examples/basic-delivery $ROOT/examples
rm -rf $ROOT/examples-temp
