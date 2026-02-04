# Zoxide configuration
#
# <https://github.com/ajeetdsouza/zoxide>
{ config, ... }:
{
  programs.zoxide.enable = true;

  home.sessionVariables._ZO_DATA_DIR = "${config.xdg.stateHome}/zoxide";
}
