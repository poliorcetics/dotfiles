# Homebrew config
#
# <https://brew.sh/>
#
# Docs: <https://docs.brew.sh/>

{
  # Manage Homebrew casks through nix-darwin.
  #
  # Needs Homebrew to be installed separately.
  #
  # When doing this, `./dotfiles.sh update` will ensure the apps are installed if not.
  # To activate auto-updates, read the documentation linked below.
  #
  # You can find all configuration options here:
  # <https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-homebrew.enable>
  homebrew = {
    enable = true;
    casks = [
      "appcleaner"
      "calibre"
      "db-browser-for-sqlite"
      "discord"
      "firefox"
      "kitty"
      "macs-fan-control"
      "monitorcontrol"
      "orbstack"
      "rectangle"
      "signal"
      "steam"
      "transmission"
      "tunnelblick"
      "utm"
      "vlc"
      "zulip"
    ];
  };
}
