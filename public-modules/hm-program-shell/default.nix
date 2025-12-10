# Shell configurations
{
  config,
  lib,
  pkgs,
  ...
}:
let
  sourceSessionVariables = lib.optionalString pkgs.stdenv.isLinux /* bash */ ''
    . "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh"
  '';
in
{
  programs.bash = {
    enable = true;
    # We use nushell to cleanup the path of duplicates.
    initExtra = /* bash */ ''
      if [ -z "$__personal_extra_init_already_done" ]; then
        ${sourceSessionVariables}
        export PATH=$(${config.home.homeDirectory}/.nix-profile/bin/nu --commands '$env.PATH | uniq | str join :')
        export __personal_extra_init_already_done=1
      fi

      # Replace the default shell with nu
      builtin exec ${config.home.homeDirectory}/.nix-profile/bin/nu
    '';
    historyFile = "${config.xdg.configHome}/bash/history";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initContent = config.programs.bash.initExtra;
    history.path = "${config.xdg.configHome}/zsh/history";
  };
}
