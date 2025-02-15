# Shell configurations
{ config, ... }:
{
  programs.bash = {
    enable = true;
    # We use nushell to cleanup the path of duplicates.
    initExtra = ''
      if [ -z "$__personal_extra_init_already_done" ]; then
        export PATH=$(${config.home.homeDirectory}/.nix-profile/bin/nu --commands '$env.PATH | uniq | str join :')
        export __personal_extra_init_already_done=1
      fi

      # Replace the default shell with nu
      builtin exec ${config.home.homeDirectory}/.nix-profile/bin/nu
    '';
    historyFile = "${config.xdg.configHome}/bash/history";
  };

  programs.zsh = {
    inherit (config.programs.bash) initExtra;
    enable = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.configHome}/zsh/history";
  };
}
