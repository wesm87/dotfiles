# shellcheck shell=bash

# Reload bash profile
function reload-bash-profile() {
  # shellcheck disable=1090
  can-source-file "$HOME/.bash_profile" && source "$HOME/.bash_profile"
}

# Reload zsh profile
function reload-zsh-profile() {
  # shellcheck disable=1090
  can-source-file "$HOME/.zshrc" && source "$HOME/.zshrc"
}

# Reload profile based on current shell
function reload-profile() {
  if __dotfiles_is_bash; then
    reload-bash-profile
    return 0
  fi

  if __dotfiles_is_zsh; then
    reload-zsh-profile
    return 0
  fi

  return 1
}

# Create a new directory and enter it
function md() {
  local file_path="$1"
  shift
  local mkdir_args="$*"

  mkdir -p "$file_path" "$mkdir_args" && cd "$file_path" || exit
}

function copy_dir() {
  local source="$1"
  local dest="${2:-.}"

  cp -rT "$source" "$dest"
}

# find shorthand
function f() {
  local pattern="$1"

  find . -name "$pattern" 2>&1 | grep -v 'Permission denied'
}

# fuzzy find
function fuzzy-find() {
  local pattern="$1"

  f "*$pattern*"
}

# List non-hidden files and directories, long format, permissions in octal
function la() {
  # shellcheck disable=2012
  ls -l "$*" | awk '{
    k=0;
    for (i=0;i<=8;i++)
    k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
    if (k)
    printf("%0o ",k);
    printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
  }'
}

# cd into whatever is the current Finder window.
# Short for cdfinder.
function cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || exit
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"

  open "http://localhost:${port}/"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Copy w/ progress
function cp-p() {
  local source="$1"
  local target="$2"

  rsync -WavP --human-readable --progress "$source" "$target"
}

# get gzipped size
function gz() {
  local file_path="$1"

  echo "orig size (bytes): "
  wc -c <"$file_path"
  echo "gzipped size (bytes): "
  gzip -c "$file_path" | wc -c
}

# whois a domain or a URL
function whois() {
  local domain

  domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
  if [ -z "$domain" ]; then
    domain=$1
  fi

  echo "Getting whois record for: $domain …"

  # avoid recursion
  # this is the best whois server
  # strip extra fluff
  /usr/bin/whois -h whois.internic.net "$domain" | sed '/NOTICE:/q'
}

function local-ip-for-device() {
  ipconfig getifaddr "$1"
}

function local-ip() {
  local-ip-for-device en0 || local-ip-for-device en1
}

function network-info() {
  function print-ip() {
    local local_ip
    local_ip=$(local-ip-for-device "$1")
    echo "📶 $local_ip"
  }
  export -f print-ip

  local purple="\x1B\[35m"
  local reset="\x1B\[m"

  networksetup -listallhardwareports |
    sed -r "s/Hardware Port: (.*)/${purple}\1${reset}/g" |
    sed -r "s/Device: (en.*)$/print-ip \1/e" |
    sed -r "s/Ethernet Address:/📘 /g" |
    sed -r "s/(VLAN Configurations)|==*//g"
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
  local file_path="$1"

  if [ -f "$file_path" ]; then
    local filename
    local foldername
    local fullpath
    local folder_exists=false

    filename=$(basename "$file_path")
    foldername="${filename%%.*}"
    fullpath=$(perl -e 'use Cwd "abs_path"; print abs_path(shift)' "$file_path")

    if [ -d "$foldername" ]; then
      folder_exists=true
      read -r -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
      echo
      if [[ $REPLY =~ ^[Nn]$ ]]; then
        return
      fi
    fi

    mkdir -p "$foldername" && cd "$foldername" || exit

    case $file_path in
    *.tar.bz2) tar xjf "$fullpath" ;;
    *.tar.gz) tar xzf "$fullpath" ;;
    *.tar.xz) tar Jxvf "$fullpath" ;;
    *.tar.Z) tar xzf "$fullpath" ;;
    *.tar) tar xf "$fullpath" ;;
    *.taz) tar xzf "$fullpath" ;;
    *.tb2) tar xjf "$fullpath" ;;
    *.tbz) tar xjf "$fullpath" ;;
    *.tbz2) tar xjf "$fullpath" ;;
    *.tgz) tar xzf "$fullpath" ;;
    *.txz) tar Jxvf "$fullpath" ;;
    *.zip) unzip "$fullpath" ;;
    *) echo "'$file_path' cannot be extracted via extract()" && cd .. && ! $folder_exists && rm -r "$foldername" ;;
    esac
  else
    echo "'$file_path' is not a valid file"
  fi
}

# who is using the laptop's camera?
function camera-used-by() {
  echo "Checking to see who is using the camera… 📷"
  usedby=$(lsof | grep -w "AppleCamera\|USBVDC\|iSight" | awk '{printf $2"\n"}' | xargs ps)
  echo -e "Recent camera uses:\n$usedby"
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
function gifify() {
  local input_file_name="$1"
  local quality_flag="$2"

  if [[ -n "$input_file_name" ]]; then
    if [[ "$quality_flag" == '--good' ]]; then
      ffmpeg -i "$1" -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - >"$input_file_name.gif"
      rm out-static*.png
    else
      ffmpeg -i "$input_file_name" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 >"$input_file_name.gif"
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# turn that video into webm.
# brew reinstall ffmpeg --with-libvpx
function webmify() {
  local input_file_name="$1"
  local output_file_name="$2"

  ffmpeg -i "$input_file_name" -vcodec libvpx -acodec libvorbis -isync -copyts -aq 80 -threads 3 -qmax 30 -y "$output_file_name" "$input_file_name.webm"
}

# visual studio code. a la `subl`
function vscode() {
  local file_path

  if [[ $# = 0 ]]; then
    open -a "Visual Studio Code"
  else
    [[ $1 = /* ]] && file_path="$1" || file_path="$PWD/${1#./}"
    open -a "Visual Studio Code" --args "$file_path"
  fi
}

# `shellswitch [bash |zsh | fish]`
#   Must be in /etc/shells
function shellswitch() {
  if is-command brew; then
    chsh -s "$(get-brew-prefix-path)/bin/${1}"
  else
    chsh -s "/bin/${1}"
  fi
}

curry shellswitch-bash shellswitch 'bash'
curry shellswitch-zsh shellswitch 'zsh'
curry shellswitch-fish shellswitch 'fish'

function git-root() {
  local git_return

  git rev-parse --is-inside-work-tree >&/dev/null
  git_return="$?"

  if [ "$git_return" == "128" ]; then
    echo 'Not a git repository'
  else
    cd "$(git rev-parse --show-toplevel)" || exit
  fi
}

function set-terminal-title-for-target() {
  local target="${1:-}"
  local title="${2:-}"

  if [ -n "$target" ]; then
    printf '\e]%s;%s\a' "$target" "$title"
  fi
}

curry set-terminal-title set-terminal-title-for-target '0'
curry set-terminal-tab-title set-terminal-title-for-target '1'
curry set-terminal-window-title set-terminal-title-for-target '2'

function set-wifi-status() {
  local status="$1"

  sudo ifconfig en0 "$status"
}

function disable-wifi() {
  set-wifi-status down
}

function enable-wifi() {
  set-wifi-status up
}

function toggle-wifi() {
  disable-wifi
  sleep 1
  enable-wifi
}

function spoof-mac-address() {
  sudo ifconfig en0 ether "${1}"
  toggle-wifi
}

function get-wifi-mac-address() {
  ifconfig | grep ether | head -n 1 | field 2
}

function get-network-location() {
  scselect 2>&1 | grep '^ \*' | sed -e 's:^[^(]*(\([^)]*\))$:\1:g'
}

function set-network-location() {
  scselect "${1}"
}

function docker-list-all-ids() {
  docker ps -a -q
}

function docker-list-unused-ids() {
  docker images -qf "dangling=true"
}

function docker-clean-unused() {
  # shellcheck disable=2155
  local images=$(docker-list-unused-ids)

  # shellcheck disable=2086
  [ -n "$images" ] && docker rmi $images
}

function docker-stop-all() {
  # shellcheck disable=2155
  local images=$(docker-list-all-ids)

  # shellcheck disable=2086
  [ -n "$images" ] && docker stop $images
}

function docker-remove-all() {
  # shellcheck disable=2155
  local images=$(docker-list-all-ids)

  # shellcheck disable=2086
  [ -n "$images" ] && docker rm $images
}

function docker-prune-containers() {
  docker container prune -f "$@"
}

function doocker-prune-images() {
  docker image prune -f "$@"
}

function docker-prune-networks() {
  docker network prune -f "$@"
}

function docker-prune-volumes() {
  docker volume prune -f "$@"
}

function docker-prune-all() {
  docker system prune
}
