# Jujutsu configuration
#
# <https://github.com/martinvonz/jj>

{
  config,
  pkgs,
  unstablePkgs,
  userDetails,
  ...
}:
let
  generateToml = (pkgs.formats.toml { }).generate;

  # Settings: <https://martinvonz.github.io/jj/latest/config/>
  settings = {
    # <https://martinvonz.github.io/jj/latest/config/#aliases>
    aliases = {
      b = [ "bookmark" ];
      c = [ "commit" ];
      cm = [
        "commit"
        "-m"
      ];
      d = [ "diff" ];
      dt = [
        "diff"
        "--tool"
        "difft"
      ];
      ds = [ "describe" ];
      g = [ "git" ];
      gf = [
        "git"
        "fetch"
      ];
      gp = [
        "git"
        "push"
      ];
      gpa = [
        "git"
        "push"
        "--all"
      ];
      l = [ "log" ];
      lb = [
        "log"
        "-r"
        "current()"
      ];
      lm = [
        "log"
        "-r"
        "::@"
      ];
      lo = [
        "log"
        "-r"
        "open()"
      ];
      r = [ "rebase" ];
      rs = [
        "rebase"
        "--source"
        "all:open_roots()"
        "--destination"
      ];
      s = [ "status" ];
      sq = [ "squash" ];
    };

    # <https://martinvonz.github.io/jj/latest/config/#git-settings>
    git = {
      private-commits = "description(glob:'local:*')";
      push-bookmark-prefix = "ab/push-";
    };

    merge-tools.difft.diff-args = [
      "--display"
      "side-by-side-show-both"
      "--color=always"
      "$left"
      "$right"
    ];

    revset-aliases = {
      "current()" = "(::@ ~ ::trunk())";
      "open()" = "(mine() ~ ::trunk())::";
      # Useful to rebase all branches with `jj r -s "all:open_roots()" -d main/master/develop/..`
      "open_roots()" = "roots(open())";
    };

    # <https://martinvonz.github.io/jj/latest/config/#snapshot-settings>
    snapshot.max-new-file-size = "10MB";

    # <https://martinvonz.github.io/jj/latest/config/#commit-signing>
    # <https://martinvonz.github.io/jj/latest/config/#ssh-signing>
    signing = {
      backend = "ssh";
      key = "~/.ssh/id_signing.pub";
      sign-all = true;
    };

    # Override the default short ID to use the absolute shortest, making it easier to use `-r <id>`
    # in various `jj` commands
    template-aliases."format_short_id(id)" = "id.shortest()";

    # <https://martinvonz.github.io/jj/latest/config/#ui-settings>
    ui = {
      # <https://martinvonz.github.io/jj/latest/conflicts/#alternative-conflict-marker-styles>
      conflict-marker-style = "snapshot";

      default-command = "status";

      pager = "delta";
      # <https://martinvonz.github.io/jj/latest/config/#diff-format>
      diff.format = "git";
    };

    # <https://martinvonz.github.io/jj/latest/config/#user-settings>
    user = {
      email = userDetails.public.email;
      name = userDetails.public.displayName;
    };
  };
in
{
  home.sessionVariables.JJ_CONFIG = "${config.xdg.configHome}/jj/config.toml";

  home.packages = [ unstablePkgs.jujutsu ];

  # Using file to get access to custom path: <https://github.com/nix-community/home-manager/issues/5001>
  xdg.configFile."jj/config.toml".source = generateToml "jj-config.toml" settings;
}
