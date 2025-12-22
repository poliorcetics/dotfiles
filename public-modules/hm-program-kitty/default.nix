# Kitty configuration
#
# <https://sw.kovidgoyal.net/kitty>
#
# Config docs: <https://sw.kovidgoyal.net/kitty/conf/>

# TODO: consider configuring <https://sw.kovidgoyal.net/kitty/kittens/ssh/#real-world-ssh-kitten-config>
{
  config,
  ...
}:
{
  # On macOS I use `brew` to manage Kitty and on Linux I use the local package manager
  programs.kitty.enable = false;

  personal.links = {
    "kitty/kitty.conf" = "public-modules/hm-program-kitty/kitty.conf";
    "kitty/theme.conf" = "public-modules/hm-program-kitty/theme.conf";
    # Technically useless on Linux but it doesn't cost anything to symlink it anyway
    "kitty/macos-launch-services-cmdline" =
      "public-modules/hm-program-kitty/macos-launch-services-cmdline";
  };

  xdg.configFile."kitty/includes/01-editor.conf".text = ''
    # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.editor>
    editor ${config.home.sessionVariables.CARGO_HOME}/bin/hx
  '';

  # <https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.env>
  xdg.configFile."kitty/includes/00-env.conf".text = builtins.concatStringsSep "\n" (
    let
      vars = config.home.sessionVariables;
    in
    builtins.map (var: ''env ${var}=${builtins.toString vars.${var}}'') (builtins.attrNames vars)
  );
}
