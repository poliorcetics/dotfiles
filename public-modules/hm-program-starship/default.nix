# Starship configuration
#
# <https://starship.rs>
{
  mkConfigLink,
}:
{
  config,
  ...
}:
{
  imports = [
    (mkConfigLink { } "starship.toml" "public-modules/hm-program-starship/config.toml")
  ];

  programs.starship.enable = true;

  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
}
