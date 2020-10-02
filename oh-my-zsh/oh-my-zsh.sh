# shellcheck shell=bash disable=1090,2034

function __dotfiles_oh_my_zsh_config() {
  local oh_my_zsh_dir_path
  local oh_my_zsh_script_file_path
  local oh_my_zsh_custom_dir_path
  local oh_my_zsh_custom_plugins_dir_path

  oh_my_zsh_dir_path="$HOME/.oh-my-zsh"
  oh_my_zsh_script_file_path="$oh_my_zsh_dir_path/oh-my-zsh.sh"
  oh_my_zsh_custom_dir_path="$HOME/.dotfiles/oh-my-zsh/custom"
  oh_my_zsh_custom_plugins_dir_path="$oh_my_zsh_custom_dir_path/plugins"

  if [ ! -d "$oh_my_zsh_dir_path" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [ ! -d "$oh_my_zsh_custom_plugins_dir_path/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$oh_my_zsh_custom_plugins_dir_path/zsh-autosuggestions"
  fi

  if [ ! -d "$oh_my_zsh_custom_plugins_dir_path/zsh-syntax-highlighting " ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$oh_my_zsh_custom_plugins_dir_path/zsh-syntax-highlighting "
  fi

  if can-source-file "$oh_my_zsh_script_file_path"; then
    export ZSH="$oh_my_zsh_dir_path"

    #* Themes to try: wezm, wedisagree, theunraveler, terminalparty
    #* https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
    #* https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes
    #* https://github.com/unixorn/awesome-zsh-plugins
    ZSH_THEME="gallois"

    # Disable auto-setting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Enable command auto-correction.
    ENABLE_CORRECTION="true"

    # Display red dots whilst waiting for completion.
    COMPLETION_WAITING_DOTS="true"

    # Disable marking untracked files under VCS as dirty.
    DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Use a custom folder other than $ZSH/custom
    ZSH_CUSTOM="$oh_my_zsh_custom_dir_path"

    plugins=('dotenv' 'git' 'nvm' 'rvm' 'z' 'zsh-autosuggestions' 'zsh-syntax-highlighting')

    source "$oh_my_zsh_script_file_path"
  fi
}

__dotfiles_oh_my_zsh_config
