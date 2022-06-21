#!/bin/bash
set -x
set +e

export REPO_NAME=$SESSION_NAMESPACE-$(date +%m%d)

mkdir $REPO_NAME
cd $REPO_NAME
echo "# Cartographer Delivery Repo" >> README.MD
git init
git checkout -b main
git config user.name gitea_admin
git config user.email "gitea_admin@example.com"
git add .
git commit -a -m "Initial Commit"

git remote add origin https://gitea_admin:VMware1\!@gitea.${INGRESS_DOMAIN}/gitea_admin/$REPO_NAME.git
git push -u origin main
