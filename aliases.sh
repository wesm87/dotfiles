# shellcheck shell=bash
# shellcheck disable=2139

# Hide a file or folder
alias hide='chflags hidden'

# Lock the computer and show the login window
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Easier navigation: .., ..., ~ and -
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'    # `cd` is probably faster to type though
alias -- -='cd -' # the `--` lets us use `-` as an alias name

# mv, rm, cp, mkdir
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias mkdir='mkdir -p'

# Shortcuts
alias tm='tmuxinator'
alias mux='tmuxinator'
alias cask='brew cask'
alias pzip='zip -e'

# Colorized grep
grep --color >/dev/null 2>&1 && alias grep='grep --color'
grep -f --color >/dev/null 2>&1 && alias fgrep='grep -f --color'
grep -E --color >/dev/null 2>&1 && alias egrep='grep -E --color'

###
# time to upgrade `ls`

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls='ls'

if gls --color >/dev/null 2>&1; then
  colorflag='--color'
else
  colorflag='-G'
fi

# ls options:
#   A = show hidden (but not . or ..)
#   F = show flags (`/` after folders, `*` after symlinks, etc.)
#   C = show in column view
#   l = show in list view
#   h = show byte unit suffixes
ls_flags="-AFhp ${colorflag} --group-directories-first"
lsc_flags="-C ${ls_flags}"
lsl_flags="-l ${ls_flags}"

# TODO: Figure out what is overriding my ls / grep aliases in Ubuntu
alias __lsc="gls ${lsc_flags}"  # column view
alias __lsl="gls ${lsl_flags}"  # list view
alias __lsd='__lsl | grep "^d"' # only directories
alias __lsf='__lsl | grep "^-"' # only files
alias __lsa='__lsl'             # files and directories

alias ls='__lsc'
alias lsc='__lsc'
alias lsl='__lsl'
alias lsd='__lsd'
alias lsf='__lsf'
alias lsd='__lsd'

# `cat` with beautiful colors. requires: sudo easy_install -U Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# Networking. IP address, dig, DNS
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias dig='dig +nocmd any +multiline +noall +answer'

# Recursively delete `.DS_Store` files
alias cleanup-dsstore='find . -name "*.DS_Store" -type f -ls -delete'

# Show total size, space used, space available, etc. for each volume
alias disk-space-report='df -P -kHl'

# File size
alias fs='stat -f "%z bytes"'

# Get today's date in YYYY-MM-DD format
alias date-today='date +%Y-%m-%d'
alias date-now='date-today'

# Empty user Trash folder
alias empty-trash='rm -rfv ~/.Trash/*'

# Empty all the user Trash folders!
alias -- empty-trash!='sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash/*'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias $method="lwp-request -m '$method'"
done

# Kroger aliases
alias gkcm="git-kroger-commit-message"
alias gkt="git-kroger-ticket"

# Custom bin aliases
alias copy-pwd='copy-cwd'
alias copy-path='copy-cwd'
