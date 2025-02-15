{
  config,
  ...
}:
{
  # Modifies PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.sessionVariables.CARGO_HOME}/bin"
    "/opt/homebrew/bin"
  ];

  home.sessionVariables = {
    EDITOR = "${config.home.sessionVariables.CARGO_HOME}/bin/hx";
    VISUAL = "${config.home.sessionVariables.CARGO_HOME}/bin/hx";

    EMCC_CACHE = "${config.xdg.cacheHome}/emscripten";

    LESS = "-R";
    LESSHISTFILE = "-";

    # Kubernetes, is a mess regarding what use which env var but let's try to make it work
    KUBECONFIG = "${config.xdg.configHome}/kube/config";
    KUBECACHEDIR = "${config.xdg.cacheHome}/kube";

    # Rust
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";

    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
  };
}
