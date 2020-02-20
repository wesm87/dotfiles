function __dotfiles_is_bash() {
  if [ -n "$BASH" ]; then return 0; else return 1; fi;
}

function __dotfiles_is_zsh() {
  if [ -n "$ZSH_NAME" ]; then return 0; else return 1; fi;
}

# Reload bash profile
function reload-bash-profile() {
  source $HOME/.bash_profile
}

# Reload zsh profile
function reload-zsh-profile() {
  source $HOME/.zshrc
}

# Reload profile based on current shell
function reload-profile() {
  if __dotfiles_is_bash; then
    reload-bash-profile
  fi

  if __dotfiles_is_zsh; then
    reload-zsh-profile
  fi
}

# Check if bash function exists
function fn-exists() {
  declare -f "$1" > /dev/null
}

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@" || exit
}

# find shorthand
function f() {
  find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# List non-hidden files and directories, long format, permissions in octal
function la() {
  ls -l  "$@" | awk '{
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
  rsync -WavP --human-readable --progress $1 $2
}

# get gzipped size
function gz() {
  echo "orig size (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# whois a domain or a URL
function whois() {
  local domain
  domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL

  if [ -z $domain ] ; then
    domain=$1
  fi
  echo "Getting whois record for: $domain …"

  # avoid recursion
  # this is the best whois server
  # strip extra fluff
  /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

function local-ip-for-device() {
  echo "$(ipconfig getifaddr $1)"
}

function local-ip() {
  echo "$(local-ip-for-device en0 || local-ip-for-device en1)"
}

function network-info() {
  function print-ip() {
    echo "📶  $(local-ip-for-device $1)";
  }
  export -f print-ip

  local purple="\x1B\[35m"
  local reset="\x1B\[m"

  networksetup -listallhardwareports | \
    sed -r "s/Hardware Port: (.*)/${purple}\1${reset}/g" | \
    sed -r "s/Device: (en.*)$/print-ip \1/e" | \
    sed -r "s/Ethernet Address:/📘 /g" | \
    sed -r "s/(VLAN Configurations)|==*//g"
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
  if [ -f "$1" ] ; then
    local filename
    local foldername
    local fullpath
    local folder_exists=false

    filename="$(basename $1)"
    foldername="${filename%%.*}"
    fullpath=$(perl -e 'use Cwd "abs_path"; print abs_path(shift)' "$1")

    if [ -d "$foldername" ]; then
      folder_exists=true
      read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
      echo
      if [[ $REPLY =~ ^[Nn]$ ]]; then
        return
      fi
    fi

    mkdir -p "$foldername" && cd "$foldername" || exit

    case $1 in
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
      *) echo "'$1' cannot be extracted via extract()" && cd .. && ! $folder_exists && rm -r "$foldername" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# who is using the laptop's iSight camera?
function camera-used-by() {
  echo "Checking to see who is using the iSight camera… 📷"
  usedby=$(lsof | grep -w "AppleCamera\|USBVDC\|iSight" | awk '{printf $2"\n"}' | xargs ps)
  echo -e "Recent camera uses:\n$usedby"
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
function gifify() {
  if [[ -n "$1" ]]; then
  if [[ $2 == '--good' ]]; then
    ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
    time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
    rm out-static*.png
  else
    ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
  fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# turn that video into webm.
# brew reinstall ffmpeg --with-libvpx
function webmify(){
  ffmpeg -i $1 -vcodec libvpx -acodec libvorbis -isync -copyts -aq 80 -threads 3 -qmax 30 -y $2 $1.webm
}

# visual studio code. a la `subl`
function vscode() {
  if [[ $# = 0 ]]; then
    open -a "Visual Studio Code"
  else
    [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
    open -a "Visual Studio Code" --args "$F"
  fi
}

# `shellswitch [bash |zsh]`
#   Must be in /etc/shells
function shellswitch() {
  chsh -s "$(brew --prefix)/bin/${1}"
}

function git-root() {
  git rev-parse --is-inside-work-tree >& /dev/null

  if [ "${?}" == "128" ]; then
    echo 'Not a git repository'
  else
    cd "$(git rev-parse --show-toplevel)" || exit
  fi
}

TERMINAL_TITLE_TARGET_ALL=0
TERMINAL_TITLE_TARGET_TAB=1
TERMINAL_TITLE_TARGET_WINDOW=2

function set-terminal-title-for-target() {
  local target="${1:-}"
  local title="${2:-}"

  if [ ! -z "$target" ]; then
    printf '\e]%s;%s\a' "$target" "$title"
  fi
}

function set-terminal-title() {
  local title="${1:-}"

  set-terminal-title-for-target $TERMINAL_TITLE_TARGET_ALL "$title"
}

function set-terminal-window-title() {
  local title="${1:-}"

  set-terminal-title-for-target $TERMINAL_TITLE_TARGET_WINDOW "$title"
}

function set-terminal-tab-title() {
  local title="${1:-}"

  set-terminal-title-for-target $TERMINAL_TITLE_TARGET_TAB "$title"
}

function disable-wifi() {
  sudo ifconfig en0 down
}

function enable-wifi() {
  sudo ifconfig en0 up
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
  echo "$(ifconfig | grep ether | head -n 1 | field 2)"
}

function get-network-location() {
  echo "$(scselect 2>&1 | grep '^ \*' | sed -e 's:^[^(]*(\([^)]*\))$:\1:g')"
}

function set-network-location() {
  scselect "${1}"
}

function docker-clean-images() {
  docker rmi "$(docker images | grep '^<none>' | field 3)"
}