# Atuin configuration
#
# <https://atuin.sh>
{
  config,
  dotfilesDir,
  unstablePkgs,
  ...
}:
{
  programs.atuin.enable = true;
  programs.atuin.package = unstablePkgs.atuin;

  xdg.configFile."atuin/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/public/home/programs/atuin/config.toml";
}
