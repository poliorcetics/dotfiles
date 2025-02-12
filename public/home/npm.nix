# NPM configuration

{ config, ... }:
{
  # NPM, incapable of answering to `XDG` spec and creating at least 3 dirs in ~/
  home.sessionVariables.NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

  # NPM has ways to configure it to not use ~/.npm but it's apparently buggy, let's hope this one works
  xdg.configFile."npm/npmrc".text = ''
    cache=${config.xdg.cacheHome}/npm
    prefix=${config.xdg.dataHome}/npm
  '';
}
