# Bat configuration
#
# <https://github.com/sharkdp/bat>

{ ... }:
{
  programs.bat.enable = true;

  # Settings: <https://github.com/sharkdp/bat#configuration-file>
  programs.bat.config.theme = "Coldark-Dark";

  home.sessionVariables = {
    MANPAGER = "bash -c 'col -bx | bat --plain --language man'";
    MANROFFOPT = "-c";
  };
}
