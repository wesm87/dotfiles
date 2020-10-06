#!/usr/bin/env bash
# shellcheck shell=bash disable=1090

source "$HOME/.dotfiles/exports/rvm.sh"

pip3 install -r requirements.txt
rvm use && bundle install
