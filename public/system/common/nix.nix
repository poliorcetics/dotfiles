{
  pkgs,
  userDetails,
  ...
}:
{
  nix.package = pkgs.nix;

  # <https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/config/nix.nix>
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/nix/default.nix>
  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";
    trusted-users = [ userDetails.username ];
  };
}
