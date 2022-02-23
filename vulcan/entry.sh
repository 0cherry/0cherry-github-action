# /entry.sh
#!/bin/bash

if [ ! -f $GITHUB_WORKSPACE/vulcan_target/.vulcan.yml ]; then
  echo "Requires .vulcan.yml in your repository"
  exit 1
fi

echo $TOKEN > token
gh auth login --with-token < token
gh auth status

source $GITHUB_ACTION_PATH/vulcan/git/config.sh
# source $GITHUB_ACTION_PATH/vulcan/git/auth.sh
source $GITHUB_ACTION_PATH/vulcan/git/checkout.sh

source $GITHUB_ACTION_PATH/vulcan/runner/run_fl.sh
source $GITHUB_ACTION_PATH/vulcan/runner/run_apr.sh

source $GITHUB_ACTION_PATH/vulcan/git/create-issue.sh
