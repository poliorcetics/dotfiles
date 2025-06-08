# Scripts to run on `home-manager switch`
{ config, lib, ... }:
let
  atuin = lib.getExe config.programs.atuin.package;
  nu = lib.getExe config.programs.nushell.package;
  starship = lib.getExe config.programs.starship.package;
  zoxide = lib.getExe config.programs.zoxide.package;

  # Automatically loaded by nushell, intended for "vendor" data, that is semi-static data that
  # doesn't change much or doesn't need to be touched by the regular user much (for me: generated
  # files). `$XDG_CONFIG_HOME/nushell/autoload` can be used to override vendor files.
  autoload = "${config.xdg.dataHome}/nushell/vendor/autoload";
in
{
  home.activation = {
    # === Usual directories ===

    # Create my expected directories
    makeDirs = ''
      run mkdir -p ~/repos/me/
      run mkdir -p ~/repos/tp/
      run mkdir -p ~/repos/work/
    '';

    # === Nushell Files ===

    # Extras files nudir
    extras = ''
      run mkdir -p ${autoload}
      run ${atuin}    init nu      > ${autoload}/atuin.nu
      run ${starship} init nu      > ${autoload}/starship.nu
      run ${zoxide}   init nushell > ${autoload}/zoxide.nu
    '';

    nushellCompletions = ''
      run mkdir -p ${autoload}
      run ${nu} ${../scripts/install-completions.nu} ${autoload}
    '';
  };
}
