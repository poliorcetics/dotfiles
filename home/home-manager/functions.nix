{ config, lib, pkgs, ... }:
{
  # Create the link `$HOME/Library/Application Support/{app_support_link} -> $XDG_CONFIG_HOME/{xdg_subdir}`
  # if it doesn't exist already
  createAppSupportSymlink = {
    xdg_subdir,
    app_support_link,
  }:
    let
      dir = "${config.xdg.configHome}/${xdg_subdir}";
      link_to_dir = "${config.home.homeDirectory}/Library/Application Support/${app_support_link}";
    in
      if !pkgs.stdenv.isDarwin || (lib.pathExists "${link_to_dir}")
      then ""
      else ''
        run mkdir -p "${dir}"
        run ln -s "${dir}" "${link_to_dir}" || true
      '';

  # Overrides a binary provided by Nix with one that ends up later in the $PATH order:
  #
  # ```nix
  # overrideNixProvideBinary "hx" (lib.getExe config.programs.helix.package) "${config.home.sessionVariables.CARGO_HOME}/bin/hx";
  # ```
  overrideNixProvidedBinary = name: nix_pkg: replacement_path: (
    lib.hiPrio (pkgs.writeShellScriptBin name ''
      if test -x "${replacement_path}"; then
        "${replacement_path}" "$@"
      else
        "${nix_pkg}" "$@"
      fi
    '')
  );
    
}
