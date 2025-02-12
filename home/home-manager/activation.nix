{ config, lib, funcs, ... }:

let 

  atuin = lib.getExe config.programs.atuin.package;
  nu = lib.getExe config.programs.nushell.package;
  starship = lib.getExe config.programs.starship.package;
  zoxide = lib.getExe config.programs.zoxide.package;

  xch = config.xdg.configHome;

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

  # Create default nushell files
  nushellDefaults = ''
    run mkdir -p ${xch}/nushell/defaults/
    run ${nu} --commands "config env --default | save -f ${xch}/nushell/defaults/env.nu"
    run ${nu} --commands "config nu  --default | save -f ${xch}/nushell/defaults/config.nu"
  '';

  # Extras files for nushell
  nushellExtras = let
    atuinNu = "${xch}/nushell/extras/atuin.nu";
  in ''
    run mkdir -p ${xch}/nushell/extras/
    run ${nu} --commands "${atuin}    init nu      | save -f ${atuinNu}"
    run ${nu} --commands "${starship} init nu      | save -f ${xch}/nushell/extras/starship.nu"
    run ${nu} --commands "${zoxide}   init nushell | save -f ${xch}/nushell/extras/zoxide.nu"
  '';
}
