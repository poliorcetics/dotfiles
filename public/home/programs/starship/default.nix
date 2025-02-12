# Starship configuration
#
# <https://starship.rs>

{ config, mkConfigLink, ... }:
{
  imports = [
    (mkConfigLink { } "starship.toml" "public/home/programs/starship/config.toml")
  ];

  programs.starship.enable = true;

  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
}
