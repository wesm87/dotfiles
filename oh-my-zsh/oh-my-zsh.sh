# shellcheck shell=bash disable=1090,2034,2128,2206

function __dotfiles_oh_my_zsh_config() {
  local -r omz_dir_path="${HOME}/.oh-my-zsh"
  local -r omz_script_file_path="${omz_dir_path}/oh-my-zsh.sh"
  local -r omz_custom_dir_path="${HOME}/.dotfiles/oh-my-zsh/custom"
  local -r omz_custom_plugins_dir_path="${omz_custom_dir_path}/plugins"
  local -a omz_built_in_plugin_names=()
  local -a omz_custom_plugin_names=()
  local current_plugin_name

  if can-source-file "$omz_script_file_path"; then
    export ZSH="$omz_dir_path"

    #* Themes to try: wezm, wedisagree, theunraveler, terminalparty
    #* https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
    #* https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes
    #* https://github.com/unixorn/awesome-zsh-plugins
    ZSH_THEME="gallois"

    # Disable auto-setting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Enable command auto-correction.
    # ENABLE_CORRECTION="true"

    # Display red dots whilst waiting for completion.
    COMPLETION_WAITING_DOTS="true"

    # Disable marking untracked files under VCS as dirty.
    DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Use a custom folder other than $ZSH/custom.
    ZSH_CUSTOM="$omz_custom_dir_path"

    # Built-in OMZ plugins.
    omz_built_in_plugin_names=(
      git
      z
    )

    # Custom OMZ plugins.
    for plugin_path in "$omz_custom_plugins_dir_path"/*; do
      current_plugin_name=$(basename "$plugin_path")
      omz_custom_plugin_names+=("$current_plugin_name")
    done

    # Combine built-in / custom plugins to create plugins array.
    plugins=($omz_built_in_plugin_names $omz_custom_plugin_names)

    # Source oh-my-zsh init script.
    source "$omz_script_file_path"
  fi
}

__dotfiles_oh_my_zsh_config
