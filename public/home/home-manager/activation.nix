{ config, lib, ... }:
let
  atuin = lib.getExe config.programs.atuin.package;
  nu = lib.getExe config.programs.nushell.package;
  starship = lib.getExe config.programs.starship.package;
  zoxide = lib.getExe config.programs.zoxide.package;

  nudir = "${config.xdg.configHome}/nushell";
in
{
  # === Usual directories ===

  # Create my expected directories
  makeDirs = ''
    run mkdir -p ~/repos/me/
    run mkdir -p ~/repos/tp/
    run mkdir -p ~/repos/work/priv/
    run mkdir -p ~/repos/work/pub/
  '';

  # === Nushell Files ===

  # Extras files nudir
  extras = ''
    run mkdir -p ${nudir}/extras/
    run ${nu} --commands "${atuin}    init nu      | save -f ${nudir}/extras/atuin.nu"
    run ${nu} --commands "${starship} init nu      | save -f ${nudir}/extras/starship.nu"
    run ${nu} --commands "${zoxide}   init nushell | save -f ${nudir}/extras/zoxide.nu"
  '';

  nushellCompletions = ''
    run mkdir -p "${nudir}/completions"
    run ${nu} ${../scripts/install-completions.nu} "${nudir}/completions"
  '';
}
