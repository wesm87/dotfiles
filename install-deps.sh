#!/usr/bin/env bash
# shellcheck shell=bash disable=1090

source "${HOME}/.dotfiles/exports/rvm.sh"

poetry install
rvm use && bundle install
