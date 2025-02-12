{ config, lib, pkgs, ... }:

let 

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
}
