# shellcheck shell=bash disable=1090

function __dotfiles_exports_gatsby() {
  # Disable Gatsby telemetry
  # https://www.gatsbyjs.org/docs/telemetry/
  export GATSBY_TELEMETRY_DISABLED=1
}
__dotfiles_exports_gatsby
