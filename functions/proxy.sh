# shellcheck shell=bash

# TODO: try using jq for json state management

export PROXY_STATE_PATH="${HOME}/.bash/state/"

export _NETWORK_LOCATION_WORK='Work'
export _NETWORK_LOCATION_AUTO='Automatic'

function proxy() {
  __proxy_check_init "$@"

  action="${1:-options}"
  shift
  "proxy_${action}" "$@"
}

function __parse_network_location() {
  local -r location=$(trim "${1}")
  local -r location_slug=$(slugify "${location}")

  case $location_slug in
  'work' | 'office' | 'vpn') echo "$_NETWORK_LOCATION_WORK" ;;
  'home' | 'automatic') echo "$_NETWORK_LOCATION_AUTO" ;;
  esac
}

function __proxy_switch_set_proxy() {
  local -r location="$1"
  local -r location_parsed=$(__parse_network_location "${location}")

  case "$location_parsed" in
  "$_NETWORK_LOCATION_WORK") proxy_start ;;
  "$_NETWORK_LOCATION_AUTO") proxy_stop ;;
  esac
}

function __proxy_switch_set_location() {
  local -r location="$1"
  local -r location_parsed=$(__parse_network_location "${location}")

  case "$location_parsed" in
  "$_NETWORK_LOCATION_WORK" | "$_NETWORK_LOCATION_AUTO") set-network-location "$location_parsed" ;;
  esac
}

function __proxy_switch_set_all() {
  local -r location="$1"

  __proxy_switch_set_location "$location" && __proxy_switch_set_proxy "$location"
}

function __proxy_switch_set_proxy_from_location() {
  local -r location=$(get-network-location)

  __proxy_switch_set_proxy "$location"
}

function proxy_switch() {
  local -r location="${1:-}"
  local -r location_parsed=$(__parse_network_location "$location")

  function proxy_switch_usage() {
    echo 'Usage'
    echo 'proxy switch [location]'
    echo 'Location can be one of the following:'
    echo '    work / office'
    echo '    home / automatic'
  }

  case "$location_parsed" in
  "$_NETWORK_LOCATION_WORK" | "$_NETWORK_LOCATION_AUTO") __proxy_switch_set_all "$location" ;;
  *) proxy_switch_usage ;;
  esac
}

function proxy_options() {
  echo 'proxy [switch|start|stop|init|env|status]'
  echo '       switch : switch between home and work network locations with proxy automatically enabled or disabled'
  echo '       start : enabled the proxy'
  echo '       stop : disable the proxy'
  echo '       init : initial setup for proxy including vpn and ssh'
  echo '       env : show the proxy environment variables'
  echo '       status : show the proxy status (active / inactive)'
  echo ''
  echo 'This terminal environment the proxy status is:'

  proxy_status
}

function __proxy_check_init() {
  if [ -z "$(__proxy_state_get_cache init)" ]; then
    if [ -z "$1" ]; then
      _info 'Hint: you may want to run "proxy init" first'
    else
      oops 'You may want to run "proxy init" first'
    fi
  fi
}

function proxy_init() {
  # Make sure we have stormssh and corkscrew installed
  if is-command brew && ! is-command stormssh; then
    brew install stormssh corkscrew
  fi

  __proxy_make_state_dir

  proxy_init_vpn
  proxy_start

  __proxy_state_set_cache init true
}

function proxy_init_vpn() {
  local PULSE_PAC='/Library/Frameworks/pulse.pac'

  if [ -e "$PULSE_Z" ]; then
    echo "file exists: ${PULSE_PAC}"
    #unlock the file
    sudo chflags nouchg "$PULSE_PAC"

    echo '----[OLD pulse.pac]----'
    cat "$PULSE_PAC"
  else
    echo "creating file: ${PULSE_PAC}"
  fi

  # create pulse.pac
  echo 'function FindProxyForURL(url, host) {return "PROXY 127.0.0.1:3128";}' | sudo tee "$PULSE_PAC" >/dev/null

  #lock the file
  sudo chflags uchg "$PULSE_PAC"
}

function __proxy_make_state_dir() {
  mkdir -p "$PROXY_STATE_PATH"
}

function __proxy_state_set() {
  cat <<-EOF >"${PROXY_STATE_PATH}.proxy"
    #!/bin/sh
    $@
EOF
}

function proxy_stop() {
  proxy_assign ''
  __proxy_state_set ''

  if is-command npm; then
    npm config set strict-ssl true
    npm config rm proxy
    npm config rm https-proxy
    npm config rm registry
  fi

  if is-command yarn; then
    yarn config delete registry
  fi

  if is-command apm; then
    apm config set strict-ssl true
    apm config rm proxy
    apm config rm https-proxy
  fi

  if is-command git; then
    git config --global --unset http.proxy
    git config --global --unset https.proxy
  fi

  proxy_ssh_stop
  __proxy_state_set_cache state stop
}

function proxy_start() {
  local -r host='localhost'
  local -r port='3128'

  __proxy_make_state_dir
  __proxy_state_set_cache state run

  http_proxy_value="http://${host}:${port}"
  https_proxy_value="http://${host}:${port}"

  # no_proxy_value="localhost,127.0.0.1,192.168/16,169.254/16,10.*,www-local.*,*.local"
  no_proxy_value="localhost,$(local-ip),*.kroger.com,localhost,127.0.0.1,192.168.0.{1..20},172.16.0.0/1,www-local.*,*-local.*,*.local,*.test"

  if is-command npm; then
    npm config set strict-ssl false
    npm config set proxy $http_proxy_value
    npm config set https-proxy $http_proxy_value
    npm config set registry http://npm.kroger.com
  fi

  if is-command yarn; then
    yarn config set registry http://npm.kroger.com
  fi

  if is-command apm; then
    apm config set strict-ssl false
    apm config set proxy $http_proxy_value
    apm config set http-proxy $http_proxy_value
    apm config set https-proxy $http_proxy_value
  fi

  if is-command git; then
    git config --global http.proxy $http_proxy_value
    git config --global https.proxy $https_proxy_value
  fi

  proxy_assign $http_proxy_value $https_proxy_value "$no_proxy_value"
  proxy_ssh_start $host
}

function proxy_assign() {
  local -r http_proxy_value=$1
  local -r https_proxy_value=$2
  local -r no_proxy_value=$3

  HTTP_PROXY_ENV='http_proxy ftp_proxy all_proxy HTTP_PROXY FTP_PROXY ALL_PROXY typings_proxy'
  HTTPS_PROXY_ENV='https_proxy HTTPS_PROXY'
  NO_PROXY_ENV='no_proxy NO_PROXY'

  for envar in $HTTP_PROXY_ENV; do
    export "$envar"="$http_proxy_value"
  done
  for envar in $HTTPS_PROXY_ENV; do
    export "$envar"="$https_proxy_value"
  done
  for envar in $NO_PROXY_ENV; do
    export "$envar"="$no_proxy_value"
  done

  __proxy_state_set 'proxy_assign' "$1" "$2" "$3"
}

function __proxy_state_set_cache() {
  local -r cache_key=$1
  local -r file="${PROXY_STATE_PATH}.proxy.${cache_key}"

  cat <<-EOF >"$file"
    $2
EOF
}

function __proxy_state_get_cache() {
  local -r cache_key="$1"
  local -r file="${PROXY_STATE_PATH}.proxy.${cache_key}"
  local file_contents
  local value

  touch "$file"
  file_contents=$(cat "$file")
  value=$(trim "$file_contents")

  echo "$value"
}

function proxy_env() {
  if [ -z "$NO_PROXY" ] && [ -z "$HTTP_PROXY" ]; then
    echo '=====[INACTIVE]====='
    echo ''
  else
    echo '=====[ACTIVE]====='
    echo ''
    env | grep -i proxy
  fi
}

function proxy_status() {
  local -r proxy_state=$(__proxy_state_get_cache state)

  if [ -n "$HTTP_PROXY" ] || [ "$proxy_state" = 'run' ]; then
    if [ -z "$HTTP_PROXY" ] || [ "$proxy_state" = 'stop' ]; then
      echo 'dirty'
    else
      echo 'active'
    fi
  fi

  echo 'inactive'
}

function proxy_ssh_start() {
  local storm_command

  if __proxy_ssh_host_exists; then
    _info 'Editing Host: github.com'
    storm_command='edit'
  else
    _info 'Adding Host: github.com'
    storm_command='add'
  fi

  storm "$storm_command" 'github.com' 'ssh.github.com:443' --o 'proxycommand=corkscrew localhost 3128 %h %p'

  # Host github.com
  #     hostname ssh.github.com
  #     port 443
  #     proxycommand corkscrew 127.0.0.1 3128 %h %p
  return
}

function proxy_ssh_stop() {
  local -r ssh_host='github.com'

  _info "Removing SSH Host ${ssh_host}"

  storm delete "$ssh_host"
}

function __proxy_ssh_host_exists() {
  local -r search_result=$(storm search 'github.com')
  local -r search_result_not_found='no results found.'

  if [ "$search_result" = "$search_result_not_found" ]; then
    # _error_ "ssh host NOT found"
    return 1
  fi

  # _info_ "ssh host found"
  return 0
}
