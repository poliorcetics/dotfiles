# Shell configurations

{ config, lib, ... }:
let

  initExtra = ''
    if [ -z "$__INIT_EXTRA_ALREADY_DONE" ]; then
      mkdir -p "$XDG_RUNTIME_DIR"

      export PATH="$($HOME/.nix-profile/bin/nu --commands '$env.PATH | uniq | str join :')"

      if [ -f "${xch}/.env" ]; then
        source "${xch}/.env"
      fi

      export __INIT_EXTRA_ALREADY_DONE=1
    fi

    # Replace the default shell with nu
    builtin exec $HOME/.nix-profile/bin/nu
  '';

  shAliases = {
    ls = "eza -F --colour-scale all --time-style long-iso --group-directories-first";
    la = "eza -haF --colour-scale all --time-style long-iso --group-directories-first";
    ll = "eza -lhaF --colour-scale all --time-style long-iso --group-directories-first";
    lm = "clear; ll";
  };

  xch = config.xdg.configHome;

in
{
  home.shellAliases = {
    # Simply shorter commands
    cg = "cargo";
    g = "git";
    j = "just";
    po = "poetry";
    # With arguments
    rgi = "rg --no-ignore --hidden";
    rgh = "rg --hidden";
    fdi = "fd -IH";

    # Calling `nix develop` with `--command` make the command be interpreted after the path
    # modifications in in the nix env init script and so nushell picks up the new paths
    nd = "nix develop --command ${lib.getExe config.programs.nushell.package}";
  };

  programs.bash = {
    enable = true;
    # The path manipulations are done here because otherwise the default .bashrc/.zshrc will prepend
    # the PATH in `home.sessionVariables` with the systems paths, which is not what I want at all
    #
    # After that, we use nushell to cleanup the path of duplicates.
    #
    # I also added a `source $XDG_CONFIG_HOME/.env` to load local env variables that I don't want to
    # share with the world, like API keys
    initExtra = initExtra;
    historyFile = "${xch}/bash/history";
    shellAliases = shAliases;
  };

  programs.zsh = {
    enable = true;
    initExtra = initExtra;
    dotDir = ".config/zsh";
    history.path = "${xch}/zsh/history";
    shellAliases = shAliases;
  };

  # === Nushell ===
  #
  # I don't manage nushell through `programs.nushell.enable` because on macOS it will create its config
  # file in `~/Library/Application Support/nushell` whereas I prefer them in `~/.config/nushell`.
  #
  # Additionally, for `atuin`, `starship`, `zoxide` and other such programs that need an extra file to
  # source, the default `<prog>.nix` will recreate the file on each new shell, e.g.:
  # <https://github.com/nix-community/home-manager/blob/5b9156fa9a8b8beba917b8f9adbfd27bf63e16af/modules/programs/atuin.nix#L133>
  # which is very slow and should not be done that way (instead a `home.activation` script would
  # probably be preferable, I should make a PR for that)

  xdg.configFile."nushell/env.nu".text = ''
    source-env ${xch}/nushell/defaults/env.nu
  '';

  xdg.configFile."nushell/config.nu".text = let
    aliasesStr = lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "alias ${k} = ${v}") config.home.shellAliases);

    nuConfig = lib.readFile ./nushell/config.nu;
  in
    ''
      source-env ${xch}/nushell/defaults/config.nu

      ${nuConfig}

      ${aliasesStr}

      source ${xch}/nushell/extras/zoxide.nu
      source ${xch}/nushell/extras/starship.nu
      # https://atuin.sh/docs
      #
      # Waiting on https://github.com/nushell/nushell/issues/10414
      source ${xch}/nushell/extras/atuin.nu
    '';
}
