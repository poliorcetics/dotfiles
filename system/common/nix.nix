{ pkgs, userDetails, ... }:
{
  # Auto upgrade nix package and the daemon service.
  # <https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/services/system/nix-daemon.nix>
  # <https://github.com/LnL7/nix-darwin/blob/a35b08d09efda83625bef267eb24347b446c80b8/modules/services/nix-daemon.nix>
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # <https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/services/misc/nix-gc.nix>
  # <https://github.com/LnL7/nix-darwin/blob/a35b08d09efda83625bef267eb24347b446c80b8/modules/services/nix-gc/default.nix>
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    interval = {
      Weekday = 7;
      Hour = 23;
      Minute = 59;
    };
  };

  # <https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/services/misc/nix-optimise.nix>
  # <https://github.com/LnL7/nix-darwin/blob/a35b08d09efda83625bef267eb24347b446c80b8/modules/services/nix-optimise/default.nix>
  nix.optimise = {
    automatic = true;
    interval = {
      Weekday = 7;
      Hour = 23;
      Minute = 59;
    };
  };

  # <https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/config/nix.nix>
  # <https://github.com/LnL7/nix-darwin/blob/a35b08d09efda83625bef267eb24347b446c80b8/modules/nix/default.nix>
  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";
    trusted-users = [ userDetails.username ];
    # Technically a GC config but not under nix.gc.
    # Disabled after <https://github.com/NixOS/nix/issues/7273>.
    auto-optimise-store = false;
  };
}
