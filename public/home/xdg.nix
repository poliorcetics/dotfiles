# XDG Setup
#
# Spec: <https://specifications.freedesktop.org/basedir-spec/latest/>
{ config, ... }:
{
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    # Put all dirs in .local because I like having $HOME as clean as possible
    cacheHome = "${config.home.homeDirectory}/.local/cache";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };

  # Where the tempdirs are created, if at all respected. The other XDG env vars are created
  # by the `xdg.enable = true` earlier
  home.sessionVariables.XDG_RUNTIME_DIR = "/var/tmp/$(id -u)";
}
