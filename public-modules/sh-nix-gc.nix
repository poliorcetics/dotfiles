{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
  inherit (lib) mkIf mkMerge;
in
{
  nix.gc = mkMerge [
    {
      automatic = true;
      options = "--delete-older-than 30d";
    }

    (mkIf isDarwin {
      interval = {
        Weekday = 7;
        Hour = 23;
        Minute = 59;
      };
    })

    (mkIf isLinux {
      dates = "weekly";
    })
  ];

  nix.optimise = mkMerge [
    {
      automatic = true;
    }

    (mkIf isDarwin {
      interval = {
        Weekday = 7;
        Hour = 23;
        Minute = 59;
      };
    })

    (mkIf isLinux {
      dates = [ "weekly" ];
    })
  ];
}
