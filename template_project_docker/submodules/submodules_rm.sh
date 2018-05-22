#!/usr/bin/env bash

git submodule deinit -f -- front
rm -rf ../../.git/modules/template_project/submodules/front
git rm -f front
