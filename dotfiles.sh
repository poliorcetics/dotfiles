#!/usr/bin/env bash

set -euo pipefail

## EARLY SETUP ##

/usr/bin/cd "$(/usr/bin/readlink -f "$0" | /usr/bin/xargs /usr/bin/dirname)"

## OS CHECK ##

uname_os="$(/usr/bin/uname -s)"

case "$uname_os" in
Linux*)
  /bin/echo "Known system: Linux"
  ;;

Darwin*)
  /bin/echo "Known system: macOS"
  ;;

*)
  /bin/echo "Unknown system: $uname_os" >&2
  builtin exit 1
  ;;
esac

## HELPERS ##

function run-with-nix() {
  /run/current-system/sw/bin/nix --show-trace --extra-experimental-features "flakes nix-command" "$@"
}

function run-linux-macos() {
  case "$uname_os" in
  Linux*)
    $1
    ;;

  Darwin*)
    $2
    ;;
  esac
}

### INITIAL SETUP ##

function _initial-setup-nix-install() {
  /bin/echo "Installing nix"
  # TODO: switch to Lix
  /bin/sh <(/usr/bin/curl -L https://nixos.org/nix/install) --daemon

  /bin/echo "Launch a new shell to get access to nix and call './dotfiles update'"
}

function initial-setup-linux() {
  _initial-setup-nix-install

  /usr/bin/sudo /usr/bin/systemctl restart nix-daemon.service
}

# Lots of stuff to do on macOS
function initial-setup-macos() {
  # Setup `sudo` with TouchID
  /usr/bin/sudo /bin/cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
  /usr/bin/sudo /usr/bin/sed -i '' '3s/^# //' /etc/pam.d/sudo_local

  # Installing XCode stuff is a requirement
  /bin/echo "xcode-select Install"
  /usr/bin/xcode-select --install

  _initial-setup-nix-install

  /usr/bin/sudo /bin/launchctl kickstart -k system/org.nixos.nix-daemon

  # Homebrew for proper .app, those from nix are often unsigned and in an unusual place
  /bin/echo "Installing Homebrew"
  /bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # That link can be created before the app is there in theory
  /bin/echo "Linking xterm info for kitty to the default XDG_DATA_HOME"
  link_dir="$HOME/.local/share/terminfo/78"
  /bin/mkdir -p "$link_dir"
  /bin/ln -s /Applications/kitty.app/Contents/Resources/terminfo/78/xterm-kitty "$link_dir/xterm-kitty"
}

## SECONDARY SETUP ##

function secondary-setup-linux() {
  ./setup/secondary-setup.nu rust installs
}

function secondary-setup-macos() {
  ./setup/secondary-setup.nu rust installs
  ./setup/secondary-setup.nu tm setup-exclusions
}

## UPDATE ##

function update-linux() {
  run-with-nix run home-manager -- switch --show-trace --flake .#linux
}

function update-macos() {
  run-with-nix run nix-darwin -- switch --show-trace --flake .#mac
}

## MAIN ##

case "$1" in
initial-setup)
  run-linux-macos initial-setup-linux initial-setup-macos
  ;;

secondary-setup)
  run-linux-macos secondary-setup-linux secondary-setup-macos
  ;;

update)
  run-linux-macos update-linux update-macos
  ;;

*)
  /bin/echo "Dotfiles handler:"
  /bin/echo ""
  /bin/echo "Commands:"
  /bin/echo "    initial-setup    Run the initial setup (installing nix & brew)"
  /bin/echo "    secondary-setup  Run the secondary setup (installing Helix, Iosevka, Rust toolchains, Rust-analyzer, ...)"
  /bin/echo "    update           Update based on the current state (ensure everything is installed)"
  ;;
esac
