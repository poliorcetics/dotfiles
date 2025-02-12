{ self
, pkgs
, userDetails
, ...
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
  homebrew = {
    enable = true;
    casks = [
      "appcleaner"
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

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = [];
  # environment.darwinConfig = "${userDetails.home}/.config/nix/flake.nix";

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

  # Create /etc/*rc that loads the nix-darwin environment.
  programs = {
    # bash.enable = true;
    zsh.enable = true; # default shell on macOS
    # fish.enable = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
