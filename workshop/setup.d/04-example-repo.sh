#!/bin/bash
set -x
set +e

# Set up sample files
#     - clone repo
#     - copy files of interest to user $HOME/intro directory
#     - replace hard-coded registry name with session registry
git clone https://github.com/ciberkleid/cartographer-concepts.git $HOME/intro-temp
mkdir -p $HOME/intro
mv $HOME/intro-temp/layout-2/* $HOME/intro
find ./intro -type f -not -path '*/\.*' -print0 | xargs -0 sed -i "s/harbor\.tanzu\.coraiberkleid\.site\/carto-demo/$REGISTRY_HOST/g"
rm -rf $HOME/intro-temp
