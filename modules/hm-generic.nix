{
  config,
  ...
}:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    inherit (config.personal) username;
    homeDirectory = config.personal.home;
  };
}
