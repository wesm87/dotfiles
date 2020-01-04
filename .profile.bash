function __dotfiles_profile_includes() {
  local base_dir="${1:-}"
  shift
  local sources="$*"

  for file in $sources; do
    local full_path="$base_dir/$file"
    if [ -f "$full_path" ]; then
      source "$full_path"
    fi
  done
}

function __dotfiles_profile() {
  local base_dir="$HOME/.dotfiles"
  local sources=(
    functions.sh
    aliases.sh
    exports.sh
    libs.sh
    completions.sh
    .profile.local
  )

  __dotfiles_profile_includes "$base_dir" "${sources[@]}"
}

__dotfiles_profile