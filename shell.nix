# Shell configurations

{ config, ... }:
{
  programs.bash = {
    enable = true;
    sessionVariables = config.home.sessionVariables;
    # The path manipulations are done here because otherwise the default .bashrc/.zshrc will prepend
    # the PATH in `home.sessionVariables` with the systems paths, which is not what I want at all
    initExtra = ''
      # TODO: Check this is used on Linux too ?
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        source $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
          source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      fi

      mkdir -p "$XDG_RUNTIME_DIR"
      export PATH="$HOME/.local/bin/:$CARGO_HOME/bin:$XDG_DATA_HOME/npm/bin:$PATH";

      $HOME/.local/share/cargo/bin/nu
    '';
    historyFile = "${config.home.homeDirectory}/.config/bash/history";
  };

  programs.zsh = {
    enable = true;
    sessionVariables = config.home.sessionVariables;
    initExtra = config.programs.bash.initExtra;
    dotDir = ".config/zsh";
    history.path = "${config.home.homeDirectory}/.config/zsh/history";
  };
}
