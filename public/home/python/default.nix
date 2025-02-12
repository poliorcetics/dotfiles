# Python configuration

{ config, ... }:
{
  home.sessionVariables.PYTHONSTARTUP = "${config.xdg.configHome}/python/rc.py";
  home.sessionVariables.VIRTUAL_ENV_DISABLE_PROMPT = 1;

  # Workaround to ensure the python history is not in ~/
  xdg.configFile."python/rc.py".source = ./rc.py;
}
