#!/usr/bin/env bash
# shellcheck shell=bash disable=1090

# shellcheck source=./exports/rvm.sh
source "${HOME}/.dotfiles/exports/rvm.sh"

poetry install
rvm use && bundle install
