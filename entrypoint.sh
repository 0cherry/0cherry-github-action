# /entrypoint.sh
#!/bin/sh


git config --global user.email "auto@gen"
git config --global user.name "auto-gen"
REPO="https://$GITHUB_ACTOR:$TOKEN@${GITHUB_SERVER_URL#https://}/$GITHUB_REPOSITORY"

echo ==========Cloning $GITHUB_REPOSITORY==========
# gh repo clone $GITHUB_REPOSITORY repo_clone
git clone $REPO repo_clone
cd repo_clone
echo ==================================

DESTINATION_BRANCH="$GITHUB_REF_NAME"
PATCH_BRANCH="$GITHUB_REF_NAME-auto-patch-$(date +%s%N)"
echo $DESTINATION_BRANCH
echo $PATCH_BRANCH

echo ==========Setting Remote==========
git remote set-url origin $REPO
# git fetch origin '+refs/heads/*:refs/heads/*' --update-head-ok
# git --no-pager branch -a -vv
echo ==================================

echo ==========Pushing Commit==========
git checkout $GITHUB_REF_NAME
git checkout -b $PATCH_BRANCH
# generate dummy
date +%s%N > dummy
git add .
git commit -m "Auto-generated"
git push origin $PATCH_BRANCH
echo ==================================

echo ==========Authenticating gh==========
echo $TOKEN > token
cat token
gh auth login --with-token < token
gh auth status
echo ==================================

echo ==========Executing PR CMD==========
COMMAND="gh pr create \
-B $DESTINATION_BRANCH \
-H $PATCH_BRANCH \
-t \"Patch Report for commit sha: $GITHUB_SHA\" \
-b \"This PR is auto-generated\" \
-d \
|| true"
echo "$COMMAND"
EXECUTE_PR_COMMAND=$(sh -c "$COMMAND")
echo $EXECUTE_PR_COMMAND
echo ==================================

