#!/usr/bin/env bash

# Log output:
#
# * 51c333e    (12 days)    <Gary Bernhardt>   add vim-eunuch
#
# Branch output:
#
# * release/v1.1    (13 days)    <Leyan Lo>   add pretty_git_branch
#
# The time massaging regexes start with ^[^<]* because that ensures that they
# only operate before the first "<". That "<" will be the beginning of the
# author name, ensuring that we don't destroy anything in the commit message
# that looks like time.
#
# The log format uses } characters between each field, and `column` is later
# used to split on them. A } in the commit subject or any other field will
# break this.

LOG_HASH="%C(always,yellow)%h%C(always,reset)"
LOG_RELATIVE_TIME="%C(always,green)(%ar)%C(always,reset)"
LOG_AUTHOR="%C(always,blue)<%an>%C(always,reset)"
LOG_SUBJECT="%s"
LOG_REFS="%C(always,red)%d%C(always,reset)"

LOG_FORMAT="$LOG_HASH}$LOG_RELATIVE_TIME}$LOG_AUTHOR}$LOG_REFS $LOG_SUBJECT"

BRANCH_PREFIX="%(HEAD)"
BRANCH_REF="%(color:red)%(color:bold)%(refname:short)%(color:reset)"
BRANCH_HASH="%(color:yellow)%(objectname:short)%(color:reset)"
BRANCH_DATE="%(color:green)(%(committerdate:relative))%(color:reset)"
BRANCH_AUTHOR="%(color:blue)%(color:bold)<%(authorname)>%(color:reset)"
BRANCH_CONTENTS="%(contents:subject)"

BRANCH_FORMAT="$BRANCH_PREFIX}$BRANCH_REF}$BRANCH_HASH}$BRANCH_DATE}$BRANCH_AUTHOR}$BRANCH_CONTENTS"

function __git_show_head() {
  __git_pretty_log -1
  git show -p --pretty="tformat:"
}

function __git_pretty_log() {
  git log --graph --pretty="tformat:${LOG_FORMAT}" "$@" | __git_pretty_format | __git_page_maybe
}

function __git_pretty_branch() {
  git branch -v --color=always --format="${BRANCH_FORMAT}" "$@" | __git_pretty_format
}

function __git_pretty_branch_sorted() {
  git branch -v --color=always --sort=-committerdate --format="${BRANCH_FORMAT}" "$@" | __git_pretty_format
}

function __git_pretty_format() {
  # Replace (2 years ago) with (2 years)
  sed -Ee 's/(^[^<]*) ago\)/\1)/' |
  # Replace (2 years, 5 months) with (2 years)
  sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?\)/\1)/' |
  # Line columns up based on } delimiter
  column -s '}' -t
}

function __git_page_maybe() {
  # Page only if we're asked to.
  if [ -n "$GIT_NO_PAGER" ]; then
    cat
  else
    # Page only if needed.
    less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines
  fi
}

function __git_view_conflicts() {
  git diff --name-only --diff-filter=U | xargs "$(git config alias-config.viewer)"
}

function __git_keep() {
  local path="${1:-'.'}"

  touch "${path%/}/.keep"
}

function __git_ignore() {
  touch .gitignore
  printf %"s\n" "$@" >> .gitignore
}

function __git_branch_name() {
  git rev-parse --abbrev-ref HEAD
}

function __git_merge_from() {
  local source_branch="${1:-'develop'}"
  # shellcheck disable=2155
  local current_branch="$(__git_branch_name)"
  local target_branch="${2:-$current_branch}"

  git checkout "$source_branch" \
    && git pull \
    && git checkout "$target_branch" \
    && git merge "$source_branch"
}

function __git_patch() {
  git --no-pager diff --no-color
}
