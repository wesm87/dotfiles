# shellcheck shell=bash

# Bash implementation of curry
# For example, say we have the following `add` function:
#   function add() { echo $(($1 + $2)) }
# We can curry it and partially-apply argument(s):
#   curry add1 add 1
# ...and call it with the remaining argument(s):
#   add1 2 # echos "3"
function curry() {
  exportfun=$1
  shift
  fun=$1
  shift
  params=$*
  cmd=$"function $exportfun() {
      more_params=\$*;
      $fun $params \$more_params;
  }"

  eval "$cmd"
}
