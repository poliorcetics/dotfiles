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
}
