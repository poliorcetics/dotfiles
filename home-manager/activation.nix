{ config, lib, pkgs, ... }:

let 

  atuin = lib.getExe config.programs.atuin.package;
  nu = lib.getExe config.programs.nushell.package;
  starship = lib.getExe config.programs.starship.package;
  zoxide = lib.getExe config.programs.zoxide.package;

  xch = config.xdg.configHome;

  # Import my helper functions
  funcs = import ./functions.nix { inherit config lib pkgs; };

in
{
  # === ~/Library/Application Support/ symlinks on macOS ===

  # Bacon doesn't respect XDG spec on macOS, force it to
  linkBaconConfig = funcs.createAppSupportSymlink {
    xdg_subdir = "bacon";
    app_support_link = "org.dystroy.bacon";
  };
  # Same for Nushell
  linkNushellConfig = funcs.createAppSupportSymlink {
    xdg_subdir = "nushell";
    app_support_link = "nushell";
  };
  # Same for Pijul
  linkPijulConfig = funcs.createAppSupportSymlink {
    xdg_subdir = "pijul";
    app_support_link = "pijul";
  };

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
  nushellExtras = ''
    run mkdir -p ${xch}/nushell/extras/
    run ${nu} --commands "${atuin}    init nu | save -f ${xch}/nushell/extras/atuin.nu"
    run ${nu} --commands "${starship} init nu | save -f ${xch}/nushell/extras/starship.nu"
    run ${nu} --commands "${zoxide}   init nushell | save -f ${xch}/nushell/extras/zoxide.nu"
  '';
}
