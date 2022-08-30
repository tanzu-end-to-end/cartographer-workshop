#!/bin/bash
set -x
set +e

# get user and password from secret, if it was used
if [ "x${GITEA_ADMIN_SECRET}" != "x"]; then
  echo "Looking up user and password from secret ${GITEA_ADMIN_SECRET}"
  GITEA_USER=$(kubectl get secret $GITEA_ADMIN_SECRET -o jsonpath='{.data.username}' | base64 -d)
  GITEA_PASSWORD=$(kubectl get secret $GITEA_ADMIN_SECRET -o jsonpath='{.data.password}' | base64 -d)
fi

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
until curl -I -f https://${GITEA_DOMAIN}/${GITEA_USER}
do
  echo -n "."
done
echo "success!"

git remote add origin https://${GITEA_USER}:${GITEA_PASSWORD}@${GITEA_DOMAIN}/${GITEA_USER}/$SESSION_NAMESPACE.git
git push -u origin main
