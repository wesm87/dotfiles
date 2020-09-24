#!/usr/bin/env bash

function install_imwheel_if_needed() {
  if ! is-installed imwheel; then
    sudo apt install imwheel
  fi
}

function create_imwheel_config() {
  if [ -f ~/.imwheelrc ]; then
    return
  fi

  cat >~/.imwheelrc <<EOF
".*"
None,      Up,   Button4, 1
None,      Down, Button5, 1
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
EOF
}

function set_imwheel_config_value() {
  local button_name="$1"
  local new_value="$2"

  sed -i "s/\($TARGET_KEY *$button_name, *\).*/\1$new_value/" ~/.imwheelrc
}

function set_imwheel_config_scroll_speed() {
  local new_value="$1"

  set_imwheel_config_value 'Button4' "$new_value"
  set_imwheel_config_value 'Button5' "$new_value"
}

function get_imwheel_config_scroll_speed() {
  awk -F 'Button4,' '{print $2}' ~/.imwheelrc
}

function get_new_scroll_speed_from_user() {
  local current_value="$1"

  zenity \
    --scale \
    --window-icon=info \
    --ok-label=Apply \
    --title="Wheelies" \
    --text "Mouse wheel speed:" \
    --min-value=1 \
    --max-value=100 \
    --value="$current_value" \
    --step 1
}

function get_new_scroll_speed_and_update_imwheel_config() {
  local current_value
  local new_value

  create_imwheel_config

  current_value=$(get_imwheel_config_scroll_speed)
  new_value=$(get_new_scroll_speed_from_user "$current_value")

  if [ "$new_value" == '' ]; then
    exit 0
  fi

  set_imwheel_config_scroll_speed "$new_value"

  cat ~/.imwheelrc
  imwheel -kill
}

get_new_scroll_speed_and_update_imwheel_config
