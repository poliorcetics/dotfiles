# Starship configuration
#
# <https://starship.rs>
{
  config,
  ...
}:
{
  programs.starship.enable = true;

  personal.links."starship.toml" = "public/modules/hm-program-starship/config.toml";

  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
}
