# /entrypoint.sh
#!/bin/sh

echo ==========Authenticating==========
echo $TOKEN > token
gh auth login --with-token < token
echo ==================================

echo ==========Cloning $GITHUB_REPOSITORY==========
gh repo clone $GITHUB_REPOSITORY repo_clone
cd repo_clone
echo ==================================

DESTINATION_BRANCH="$GITHUB_REF_NAME"
SOURCE_BRANCH="$GITHUB_REF_NAME-auto-patch-$(date +%s%N)"
echo $DESTINATION_BRANCH
echo $SOURCE_BRANCH

echo ==========Setting Remote==========
git remote set-url origin "https://$GITHUB_ACTOR:$TOKEN@${GITHUB_SERVER_URL#https://}/$GITHUB_REPOSITORY"
git fetch origin '+refs/heads/*:refs/heads/*' --update-head-ok
git --no-pager branch -a -vv
echo ==================================

echo ==========Pushing Commit==========
git checkout $GITHUB_REF_NAME
git checkout -b $SOURCE_BRANCH
# generate dummy
echo dummy > dummy
git add .
git commit -m "Auto-generated"
git push origin $SOURCE_BRANCH
echo ==================================


COMMAND="gh pr create \
--assignee @me \
-B $DESTINATION_BRANCH \
-H $SOURCE_BRANCH \
-t \"Generate pull-request\" \
-b \"This PR is auto-generated\" \
$PR_ARG \
|| true"

echo "$COMMAND"

PR_URL=$(sh -c "$COMMAND")
if [[ "$?" != "0" ]]; then
  echo 
  exit 1
fi

echo =====================

echo $GITHUB_ACTOR
echo $TOKEN
echo $GITHUB_REPOSITORY
echo $GITHUB_REF
echo $GITHUB_SHA

echo =====================

