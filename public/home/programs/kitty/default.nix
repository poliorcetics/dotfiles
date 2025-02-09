# Kitty configuration
#
# <https://sw.kovidgoyal.net/kitty>
#
# Config docs: <https://sw.kovidgoyal.net/kitty/conf/>

{ config, mkProgramFile, ... }:
{
  imports = [
    (mkProgramFile { } "kitty" "kitty.conf")
    (mkProgramFile { } "kitty" "macos-launch-services-cmdline")
  ];

  programs.kitty.enable = true;

  xdg.configFile."kitty/includes/editor.conf".text = ''
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.editor>
    editor ${config.home.homeDirectory}/.nix-profile/bin/hx
  '';
}
