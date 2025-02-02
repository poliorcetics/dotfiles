# GitHub tool configuration
#
# <https://cli.github.com/manual/>

{
  config,
  lib,
  dotfilesDir,
  ...
}:
{
  programs.gh.enable = true;

  xdg.configFile."gh/config.yml".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/public/home/programs/gh/config.yml"
  );
  xdg.configFile."gh/hosts.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/public/home/programs/gh/hosts.yml";
}
