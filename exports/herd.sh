# shellcheck shell=bash

function __dotfiles_exports_herd() {
  local -r herd_application_support_folder="${HOME}/Library/Application Support/Herd"
  local -r herd_php_versions_folder="${herd_application_support_folder}/config/php"

  # Herd injected PHP binary.
  export PATH="${herd_application_support_folder}/bin:${PATH}"

  # Herd injected PHP 7.4 configuration.
  export HERD_PHP_74_INI_SCAN_DIR="${herd_php_versions_folder}/74/"

  # Herd injected PHP 8.0 configuration.
  export HERD_PHP_80_INI_SCAN_DIR="${herd_php_versions_folder}/80/"

  # Herd injected PHP 8.1 configuration.
  export HERD_PHP_81_INI_SCAN_DIR="${herd_php_versions_folder}/81/"

  # Herd injected PHP 8.2 configuration.
  export HERD_PHP_82_INI_SCAN_DIR="${herd_php_versions_folder}/82/"

  # Herd injected PHP 8.3 configuration.
  export HERD_PHP_83_INI_SCAN_DIR="${herd_php_versions_folder}/83/"
}

__dotfiles_exports_herd
