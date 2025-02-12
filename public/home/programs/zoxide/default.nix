# Zoxide configuration
#
# <https://github.com/ajeetdsouza/zoxide>
{ config, ... }:
{
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = false;
  };

  home.sessionVariables._ZO_DATA_DIR = "${config.xdg.stateHome}/zoxide";
}
