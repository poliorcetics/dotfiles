# Python configuration
{
  config,
  pkgs,
  ...
}:
{
  # Workaround to ensure the python history is not in ~/
  personal.links."python/rc.py" = "modules/hm-program-python/rc.py";

  home.packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.python
    uv
  ];

  home.sessionVariables.PYTHONSTARTUP = "${config.xdg.configHome}/python/rc.py";
  home.sessionVariables.VIRTUAL_ENV_DISABLE_PROMPT = 1;
}
