# shellcheck shell=bash disable=1090,2154

# Git Prompt (enhanced prompt with Git repo info).

function __dotfiles_exports_bash_git_prompt() {
  local git_prompt_dir_path
  local git_prompt_script_file_path
  local git_prompt_colors_file_path

  if ! is-command brew; then
    return
  fi

  # -- See if the Homebrew package is installed.
  git_prompt_dir_path="$(get-brew-prefix-path bash-git-prompt)/share/"
  git_prompt_script_file_path="$git_prompt_dir_path/gitprompt.sh"
  git_prompt_colors_file_path="$git_prompt_dir_path/prompt-colors.sh"

  if can-source-file "$git_prompt_script_file_path"; then

    # If so, import ASNI color codes and export custom configuration.
    can-source-file "$git_prompt_colors_file_path" && source "$git_prompt_colors_file_path"

    export __GIT_PROMPT_DIR="$git_prompt_dir_path"
    export GIT_PROMPT_ONLY_IN_REPO=0
    export GIT_PROMPT_THEME=Default
    export GIT_PROMPT_COMMAND_OK="${Green}✔${ResetColor}"
    export GIT_PROMPT_COMMAND_FAIL="${Red}✘:_LAST_COMMAND_STATE_${ResetColor}"
    export GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${Yellow}\W${ResetColor}"
    export GIT_PROMPT_END_USER=" \$ ${ResetColor}"

    source "$git_prompt_script_file_path"
  fi
}

__dotfiles_exports_bash_git_prompt
