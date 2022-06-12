kapp deploy --yes -a gitwriter-sc -f <(ytt --ignore-unknown-comments -f ./app-operator  -f values.yaml)

