#!/usr/bin/env bash

BRANCH=${1:-master}

git submodule add --force -b $BRANCH <paste repo https path here> front
git submodule update --init
git submodule update --recursive --remote --force
