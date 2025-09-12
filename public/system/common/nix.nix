{
  pkgs,
  inputs,
  userDetails,
  ...
}:
{
  nix.package = pkgs.nix;

  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/misc/nix-gc.nix>
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/services/nix-gc/default.nix>
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/misc/nix-optimise.nix>
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/services/nix-optimise/default.nix>
  nix.optimise.automatic = true;

  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/config/nix-flakes.nix>
  nix.registry = rec {
    # Stable goes by two names
    nixpkgs.flake = inputs.nixpkgs;
    stable.flake = inputs.nixpkgs;
    # Installed unstable
    unstable.flake = inputs.nixpkgs-unstable;
    # Actual latest unstable, useful to test things without updating my whole config
    latest = {
      from = {
        type = "indirect";
        id = "latest";
      };
      to = {
        type = "github";
        owner = "nixos";
        repo = "nixpkgs";
        ref = "nixpkgs-unstable";
      };
    };

    # Aliases, for less typing
    l = latest;
    n = nixpkgs;
    s = stable;
    u = unstable;
  };

  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/config/nix.nix>
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/nix/default.nix>
  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";
    trusted-users = [ userDetails.username ];
  };
}
