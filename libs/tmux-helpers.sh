#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

get_tmux_cwd() {
  tmux display -p -F '#{pane_current_path}'
}

###
## Show git branch.
###

branch_symbol=''

show_git_branch() {
  tmux_path="$(get_tmux_cwd)"

  cd "$tmux_path"

  branch=""
  git_branch="$(__parse_git_branch)"

  if [ -n "$git_branch" ]; then
    branch="$git_branch"
  fi

  if [ -n "$branch" ]; then
    echo "${branch}"
  fi

  return 0
}

__parse_git_branch() {
  if ! git &>/dev/null; then
    return
  fi

  # Quit if this is not a Git repo.
  branch=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -z $branch ]] ; then
    # attempt to get short-sha-name
    branch=":$(git rev-parse --short HEAD 2> /dev/null)"
  fi
  if [ "$?" -ne 0 ]; then
    # this must not be a git repo
    return
  fi

  # Clean off unnecessary information.
  branch="${branch#refs\/heads\/}"

  echo  -n "${branch_symbol} ${branch}"
}
