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
    personal = {
      links = {
        # NOTE: niri config will likely evolve a lot
        "niri/config.kdl" = "modules/home-manager/program-niri/niri-config.kdl";
        # TODO: style swaylock
        # <https://github.com/swaywm/swaylock/blob/master/swaylock.1.scd>
        "swaylock/config" = "modules/home-manager/programs-niri/swaylock-config";
        # TODO: configure waybar
        # <https://github.com/Alexays/Waybar/wiki/Configuration>
        "waybar/config.jsonc" = "modules/home-manager/programs-niri/waybar-config.jsonc";
        # TODO: style waybar
        # <https://github.com/Alexays/Waybar/wiki/Styling>
        "waybar/style.css" = "modules/home-manager/programs-niri/waybar-style.css";
      };
    };
  };
}
