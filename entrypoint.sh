# /entrypoint.sh
#!/bin/sh


git config --global user.email "auto@gen"
git config --global user.name "auto-gen"

echo ==========Authenticating==========
echo $TOKEN > token
cat token
gh auth login --with-token < token
echo $(gh auth status)
echo ==================================

echo ==========Cloning $GITHUB_REPOSITORY==========
# gh repo clone $GITHUB_REPOSITORY repo_clone
git clone "https://$GITHUB_ACTOR:$TOKEN@${GITHUB_SERVER_URL#https://}/$GITHUB_REPOSITORY"
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
date +%s%N > dummy
git add .
git commit -m "Auto-generated"
git push origin $SOURCE_BRANCH
echo ==================================

echo ==========Executing PR CMD==========
COMMAND="gh pr create \
-B $DESTINATION_BRANCH \
-H $SOURCE_BRANCH \
-t \"Generate pull-request\" \
-b \"This PR is auto-generated\" \
-d \
|| true"
echo "$COMMAND"
EXECUTE_PR_COMMAND=$(sh -c "$COMMAND")
echo $EXECUTE_PR_COMMAND
echo ==================================

