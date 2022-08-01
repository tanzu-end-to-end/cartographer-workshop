#!/bin/bash
set -x
set +e

mkdir $SESSION_NAMESPACE
cd $SESSION_NAMESPACE
echo "# Cartographer Delivery Repo" >> README.MD
git init
git checkout -b main
git config user.name ${GITEA_USER}
git config user.email "${GITEA_USER}@example.com"
git add .
git commit -a -m "Initial Commit"

git remote add origin https://${GITEA_USER}:${GITEA_PASSWORD}@gitea.${INGRESS_DOMAIN}/gitea_admin/$SESSION_NAMESPACE.git
git push -u origin main
