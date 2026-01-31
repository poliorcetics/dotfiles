# Atuin configuration
#
# <https://atuin.sh>
{
  unstablePkgs,
}:
{
  programs.atuin.enable = true;
  programs.atuin.package = unstablePkgs.atuin;

  personal.links."atuin/config.toml" = "modules/hm-program-atuin/config.toml";
}
