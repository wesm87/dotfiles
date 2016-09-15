#!/usr/bin/env bash
# shellcheck disable=2155

bash_profile() {
	local base_dir="$HOME/.dotfiles"

	# shellcheck source=./.aliases
	source $base_dir/.aliases;

	# shellcheck source=./.exports
	source $base_dir/.exports;

	# shellcheck source=./.functions
	source $base_dir/.functions;

	# shellcheck source=/dev/null
	source $HOME/.bash/z/z.sh;

	# Completions
	local completions_dir="$(brew --prefix)/etc/bash_completion.d"

	# -- Git
	# shellcheck source=./completions/git-completion.bash
	source $base_dir/completions/git-completion.bash

	# -- Bash
	if [ ! -L "$completions_dir/brew_bash_completion.sh" ]; then
		ln -s "$(brew --repository)/Library/Contributions/brew_bash_completion.sh" "$completions_dir"
	fi

	# -- VV
	if [ ! -L "$completions_dir/vv-completions" ] && [ -d "$(which vv)-completions" ]; then
		ln -s "$(which vv)-completions" "$completions_dir"
	fi
}

bash_profile
