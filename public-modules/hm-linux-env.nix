{
  config,
  ...
}:
{
  xdg.configFile."bash/env.sh".text = builtins.concatStringsSep "\n" (
    let
      vars = config.home.sessionVariables;
    in
    builtins.map (var: ''export ${var}="${builtins.toString vars.${var}}"'') (builtins.attrNames vars)
  );
}
