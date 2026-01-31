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
      "niri/config.kdl" = "modules/hm-program-niri/config.kdl";
    };
  };
}
