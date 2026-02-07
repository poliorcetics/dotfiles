#!/usr/bin/env bash

set -euo pipefail

# The path of nix is not the same on Linux and Darwin,
function run-with-nix() {
  local nix_path
  nix_path=$(/usr/bin/which nix)
  /usr/bin/read -p "Nix used: $nix_path [Enter]"
  nix --version
  nix --show-trace --extra-experimental-features "flakes nix-command" "$@"
}

run-with-nix "$@"
