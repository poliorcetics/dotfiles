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

    (mkIf isLinux {
      dates = "weekly";
    })
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
