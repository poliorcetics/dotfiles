{ config, lib, ... }:

let

  atuin = lib.getExe config.programs.atuin.package;
  nu = lib.getExe config.programs.nushell.package;
  starship = lib.getExe config.programs.starship.package;
  zoxide = lib.getExe config.programs.zoxide.package;

  xch = config.xdg.configHome;
  nudir = "${xch}/nushell";

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
    run mkdir -p ${nudir}/defaults/
    run ${nu} --commands "config env --default | save -f ${nudir}/defaults/env.nu"
    run ${nu} --commands "config nu  --default | save -f ${nudir}/defaults/config.nu"
  '';

  # Extras files nudir
  Extras =
    let
      atuinNu = "${nudir}/extras/atuin.nu";
    in
    ''
      run mkdir -p ${nudir}/extras/
      run ${nu} --commands "${atuin}    init nu      | save -f ${atuinNu}"
      run ${nu} --commands "${starship} init nu      | save -f ${nudir}/extras/starship.nu"
      run ${nu} --commands "${zoxide}   init nushell | save -f ${nudir}/extras/zoxide.nu"
    '';

  nushellCompletions = ''
    run mkdir -p "${nudir}/completions"
    run ${nu} ${./../scripts/install-completions.nu} "${nudir}/completions"
  '';
}
