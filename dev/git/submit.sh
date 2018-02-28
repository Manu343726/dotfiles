#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo Pushing branch $BRANCH for review
git push origin HEAD:refs/for/$BRANCH
