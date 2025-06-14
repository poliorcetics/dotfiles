{
  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/misc/nix-gc.nix>
  nix.gc.dates = "weekly";
  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/misc/nix-optimise.nix>
  nix.optimise.dates = "weekly";

  # Never change this on an already installed machine without careful reading of the docs.
  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/misc/version.nix#L195>
  system.stateVersion = "25.05";
}
