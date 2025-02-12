# Zoxide configuration
#
# <https://github.com/ajeetdsouza/zoxide>

{ config, ... }:
{
  home.sessionVariables._ZO_DATA_DIR = "${config.xdg.stateHome}/zoxide";

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = false;
  };
}
