{ pkgs, userDetails, ... }:
{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = pkgs.system;

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

  nix.optimise = {
    automatic = true;
    interval = {
      Weekday = 7;
      Hour = 23;
      Minute = 59;
    };
  };

  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";
    trusted-users = [ userDetails.username ];
    # Technically a GC config but not under nix.gc.
    # Disabled after <https://github.com/NixOS/nix/issues/7273>.
    auto-optimise-store = false;
  };
}
