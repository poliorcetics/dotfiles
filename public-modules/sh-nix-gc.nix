{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) mkIf mkMerge;
in
{
  nix.gc = mkMerge [
    {
      automatic = true;
      options = "--delete-older-than 30d";
    }
  ];

  nix.optimise = mkMerge [
    {
      automatic = true;
    }

    (mkIf isLinux {
      dates = [ "weekly" ];
    })
  ];
}
