# /entrypoint.sh
#!/bin/sh


git config --global user.email "auto@gen"
git config --global user.name "auto-gen"
REPO="https://$GITHUB_ACTOR:$TOKEN@${GITHUB_SERVER_URL#https://}/$GITHUB_REPOSITORY"

# gh repo clone $GITHUB_REPOSITORY repo_clone
git clone $REPO repo_clone
cd repo_clone
echo ==========Cloned $GITHUB_REPOSITORY==========

DESTINATION_BRANCH="$GITHUB_REF_NAME"
PATCH_BRANCH="$GITHUB_REF_NAME-auto-patch-$(date +%s%N)"

echo ==========Switching to $PATCH_BRANCH==========
# git remote set-url origin $REPO
# git fetch origin '+refs/heads/*:refs/heads/*' --update-head-ok
# git --no-pager branch -a -vv
git checkout $DESTINATION_BRANCH
git checkout -b $PATCH_BRANCH
echo ==================================

echo "##########"Processing FL"##########"
echo "##########"Processing APR"##########"
echo "##########"Processing VALIDATOR"##########"

echo ==========Pushing change==========
# generate dummy
date +%s%N > dummy
git add .
git commit -m "Auto-generated"
git push origin $PATCH_BRANCH
echo ==================================

echo ==========gh auth login==========
echo $TOKEN > token
gh auth login --with-token < token
gh auth status
echo ==================================

echo ==========Creating PR==========
echo from: $PATCH_BRANCH
echo into: $DESTINATION_BRANCH
SHORT_COMMIT=${GITHUB_SHA:0:6}
COMMAND="gh pr create \
-B $DESTINATION_BRANCH \
-H $PATCH_BRANCH \
-t \"Patch Report for commit: $SHORT_COMMIT\" \
-b \"This PR is auto-patch for commit: $GITHUB_SHA\" \
|| true"
echo "$COMMAND"
EXECUTE_PR_COMMAND=$(sh -c "$COMMAND")
echo $EXECUTE_PR_COMMAND
echo ==================================

