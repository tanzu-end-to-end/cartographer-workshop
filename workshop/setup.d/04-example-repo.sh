#!/bin/bash
set -x
set +e

cd $HOME/exercises

# Set up sample files
#     - clone repo
#     - copy files of interest to user ./intro directory
#     - replace hard-coded registry name with session registry
#git clone https://github.com/ciberkleid/cartographer-concepts.git ./intro-temp
#mkdir -p ./intro
#mv ./intro-temp/layout-2/* ./intro
#find ./intro -type f -not -path '*/\.*' -print0 | xargs -0 sed -i "s/harbor\.tanzu\.coraiberkleid\.site\/carto-demo/$REGISTRY_HOST/g"
#rm -rf ./intro-temp

# Download cartographer repo examples
#     - update cluster resource names to be session-specific
#git clone https://github.com/vmware-tanzu/cartographer.git ./examples-temp
#mkdir -p ./examples
#mv ./examples-temp/examples/gitwriter-sc ./examples
#mv ./examples-temp/examples/basic-delivery ./examples
#rm -rf ./examples-temp

# Set up ./values.yaml for gitops workflow
GIT_USER=git-user
GITOPS_REPO="http://git-server.cartographer-portal-w08-s020.svc.cluster.local:80/hello-world-ops.git"
GITOPS_BRANCH="main"
GITOPS_COMMIT_MESSAGE="Update config"

echo "#@data/values" > ./values.yaml
echo "---" >> ./values.yaml
pathEnv=".image_prefix"  valueEnv=$( echo "${REGISTRY_HOST}/" ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
# git writer
pathEnv=".git_user_name"  valueEnv=$( echo ${GIT_USER} ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
pathEnv=".git_user_email"  valueEnv=$( echo "${GIT_USER}@example.com" ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
pathEnv=".git_writer.repository"  valueEnv=$( echo ${GITOPS_REPO} ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
pathEnv=".git_writer.branch"  valueEnv=$( echo ${GITOPS_BRANCH} ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
# git delivery
pathEnv=".git_repository"  valueEnv=$( echo ${GITOPS_REPO} ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
pathEnv=".git_branch"  valueEnv=$( echo ${GITOPS_BRANCH} ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
pathEnv=".git_commit_message"  valueEnv=$( echo ${GITOPS_COMMIT_MESSAGE} ) yq -i 'eval(strenv(pathEnv)) |= strenv(valueEnv)' ./values.yaml
# SA
yq -i '.service_account_name = "default"' ./values.yaml
