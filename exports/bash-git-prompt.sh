# shellcheck shell=bash
# shellcheck disable=1090,2154

# Git Prompt (enhanced prompt with Git repo info).

function bash_git_prompt_exports() {
  if ! is-brew-installed; then
    return
  fi

  # -- See if the Homebrew package is installed.
  __GIT_PROMPT_DIR="$(brew --prefix bash-git-prompt)/share/"

  if [ -f "$__GIT_PROMPT_DIR/gitprompt.sh" ]; then

    # If so, import ASNI color codes and export custom configuration.
    source "$__GIT_PROMPT_DIR/prompt-colors.sh"

    export __GIT_PROMPT_DIR
    export GIT_PROMPT_ONLY_IN_REPO=0
    export GIT_PROMPT_THEME=Default
    export GIT_PROMPT_COMMAND_OK="${Green}✔${ResetColor}"
    export GIT_PROMPT_COMMAND_FAIL="${Red}✘:_LAST_COMMAND_STATE_${ResetColor}"
    export GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${Yellow}\W${ResetColor}"
    export GIT_PROMPT_END_USER=" \$ ${ResetColor}"

    # shellcheck source=/dev/null
    source "$__GIT_PROMPT_DIR/gitprompt.sh"
  fi
}

bash_git_prompt_exports
