# Atuin configuration
#
# <https://atuin.sh>

{
  programs.atuin.enable = true;

  # Settings: <https://atuin.sh/docs/config/>
  programs.atuin.settings = {
    update_check = false;
    sync_frequency = "24h";
    filter_mode_shell_up_key_binding = "directory";
    enter_accept = true;
    sync.records = true;
  };
}
