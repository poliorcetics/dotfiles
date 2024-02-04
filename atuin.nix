# Atuin configuration
#
# <https://atuin.sh>

{ config, ... }:
{
  programs.atuin.enable = true;

  programs.atuin.enableBashIntegration = true;
  programs.atuin.enableFishIntegration = true;
  programs.atuin.enableNushellIntegration = true;
  programs.atuin.enableZshIntegration = true;

  programs.atuin.flags = [ "--disable-up-arrow" ];

  # Settings: <https://atuin.sh/docs/config/>
  programs.atuin.settings = {
    update_check = false;
    sync_frequency = "24h";
    filter_mode_shell_up_key_binding = "directory";
    enter_accept = true;
  };
}
