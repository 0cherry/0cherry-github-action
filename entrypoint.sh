# /entrypoint.sh
#!/bin/sh

echo =====================

echo $GITHUB_ACTOR
echo $TOKEN
echo $GITHUB_REPOSITORY
echo $GITHUB_REF
echo $GITHUB_SHA

echo =====================

# print Hello Action
