# Niri configuration
#
# <https://yalter.github.io/niri/>

{
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isLinux {
    personal.links = {
      "niri/config.kdl" = "public-modules/hm-program-niri/config.kdl";
    };
  };
}
