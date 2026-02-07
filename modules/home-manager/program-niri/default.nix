# Niri configuration
#
# <https://yalter.github.io/niri/>

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.personal.niri;
in
{
  options.personal.niri.enable-extra-binaries = lib.mkEnableOption "extra binaries used by Niri";

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

      # By default don't install those through home-manager
      global-packages = lib.mkIf cfg.enable-extra-binaries {
        fuzzel = "${pkgs.fuzzel}/bin/fuzzel";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        swaylock = "${pkgs.swaylock}/bin/swaylock";
        waybar = "${pkgs.waybar}/bin/waybar";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
      };
    };
  };
}
