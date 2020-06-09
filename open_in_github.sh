#!/usr/bin/env bash

# Script to execute from vim to get a browser window open on the
# current file and line number
#
# $1 filename
# $2 line number

REPO_URL=`git remote --v | \
  grep origin | \
  head -n 1 | \
  awk '{ print $2 }' | \
  sed 's/git\@github\.com\:/https:\/\/github.com\//' | sed 's/\.git//'`

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# open url in default browser
open "$REPO_URL/blob/$CURRENT_BRANCH/$1#L$2"
