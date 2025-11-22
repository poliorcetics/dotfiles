{
  userDetails,
}:
{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) mkIf mkMerge;
in
{
  nix.settings = mkMerge [
    {
      # Necessary for using flakes.
      experimental-features = "nix-command flakes";
      trusted-users = [ userDetails.username ];
    }

    # Technically a GC config but not under nix.gc.
    # Disabled after <https://github.com/NixOS/nix/issues/7273>.
    (mkIf isDarwin {
      auto-optimise-store = false;
    })
  ];
}
