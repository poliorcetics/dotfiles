# Kitty configuration
#
# <https://sw.kovidgoyal.net/kitty>
#
# Config docs: <https://sw.kovidgoyal.net/kitty/conf/>

{
  config,
  isLinux,
  mkProgramFile,
  ...
}:
{
  imports = [
    (mkProgramFile { } "kitty" "kitty.conf")
    (mkProgramFile { } "kitty" "macos-launch-services-cmdline")
  ];

  # On macOS I use `brew` to manage Kitty
  programs.kitty.enable = isLinux;
  # We do manual shell integration
  programs.kitty.shellIntegration.mode = "disabled";

  xdg.configFile."kitty/includes/editor.conf".text = ''
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.editor>
    editor ${config.home.sessionVariables.CARGO_HOME}/bin/hx
  '';
}
