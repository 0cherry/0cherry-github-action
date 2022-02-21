# /entrypoint.sh
#!/bin/sh

echo =====================

echo $GITHUB_ACTOR
echo $GITHUB_TOKEN
echo $GITHUB_REPOSITORY
echo $GITHUB_REF
echo $GITHUB_SHA

echo =====================

# print Hello Action
