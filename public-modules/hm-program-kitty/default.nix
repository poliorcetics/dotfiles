# Kitty configuration
#
# <https://sw.kovidgoyal.net/kitty>
#
# Config docs: <https://sw.kovidgoyal.net/kitty/conf/>

# TODO: consider configuring <https://sw.kovidgoyal.net/kitty/kittens/ssh/#real-world-ssh-kitten-config>
{
  mkProgramFile,
}:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # It's not a big deal to import this even on Linux
  imports = [
    (mkProgramFile { } "kitty" "kitty.conf")
    (mkProgramFile { } "kitty" "theme.conf")
    (mkProgramFile { } "kitty" "macos-launch-services-cmdline")
  ];

  config = lib.mkIf pkgs.stdenv.isDarwin {
    # On macOS I use `brew` to manage Kitty and on Linux I don't use Kitty at all
    programs.kitty.enable = false;

    xdg.configFile."kitty/includes/editor.conf".text = ''
      # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.editor>
      editor ${config.home.sessionVariables.CARGO_HOME}/bin/hx
    '';

    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.env>
    xdg.configFile."kitty/includes/env.conf".text = builtins.concatStringsSep "\n" (
      let
        vars = config.home.sessionVariables;
      in
      builtins.map (var: ''env ${var}=${builtins.toString vars.${var}}'') (builtins.attrNames vars)
    );
  };
}
