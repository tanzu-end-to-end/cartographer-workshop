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

# wait for server availability
echo -n "Waiting for https://${GITEA_DOMAIN}/${GITEA_USER}"
until ! curl -I -f https://${GITEA_DOMAIN}/${GITEA_USER}
do
  echo -n "."
done
echo "success!"

git remote add origin https://${GITEA_USER}:${GITEA_PASSWORD}@${GITEA_DOMAIN}/${GITEA_USER}/$SESSION_NAMESPACE.git
git push -u origin main
