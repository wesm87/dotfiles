#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

pip3 install -r requirements.txt
rvm use && bundle install
