# Shell configurations
{
  config,
  ...
}:
{
  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.configHome}/bash/history";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initContent = config.programs.bash.initExtra;
    history.path = "${config.xdg.configHome}/zsh/history";
  };
}
