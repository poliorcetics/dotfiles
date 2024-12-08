{
  pkgs,
  self,
  userDetails,
  ...
}:
let
  username = userDetails.username;
in
{
  users.users.${username} = {
    inherit (userDetails) home;
    name = username;
  };

  # Manage Homebrew casks through nix-darwin.
  #
  # Needs Homebrew to be installed separately.
  #
  # When doing this, `./dotfiles.sh update` will ensure the apps are installed if not.
  # To activate auto-updates, read the documentation linked below.
  #
  # You can find all configuration options here:
  # <https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable>
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

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    interval = {
      Hour = 23;
      Minute = 59;
    };
  };

  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";
    trusted-users = [ username ];
    # Technically a GC config but not under nix.gc.
    # Disabled after <https://github.com/NixOS/nix/issues/7273>.
    auto-optimise-store = false;
  };

  # Default shell on macOS
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
