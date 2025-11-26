platform:
{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;

  cfg = config.personal;

  baseHomeDir =
    {
      darwin = "/Users";
      linux = "/home";
    }
    .${platform};
in
{
  options.personal = {
    username = mkOption {
      type = types.nonEmptyStr;
      default = "alexis";
      description = ''
        Username of main user.
      '';
    };

    home = mkOption {
      type = types.nonEmptyStr;
      default = "${baseHomeDir}/${cfg.username}";
      readOnly = true;
      description = ''
        Absolute path to home directory of user.
      '';
    };

    dotfilesSubDir = mkOption {
      type = types.nonEmptyStr;
      default = "repos/me/dotfiles";
      description = ''
        Path to dotfiles (relative to user home).

        Should not start nor end with `/`.
      '';
    };

    dotfilesDir = mkOption {
      type = types.nonEmptyStr;
      default = "${cfg.home}/${cfg.dotfilesSubDir}";
      readOnly = true;
      description = ''
        Absolute path to dotfiles directory of user.

        Notably used for `mkOutOfStoreSymlink` wrappers.
      '';
    };

    nixFlavor = mkOption {
      type = types.enum [
        "lix"
        "nix"
      ];
      default = "lix";
      description = ''
        Nix implementation to use for this machine.
      '';
    };

    public.vcsDisplayName = mkOption {
      type = types.nonEmptyStr;
      default = "Alexis (Poliorcetics) Bourget";
      description = ''
        Name used in commits in public repositories.
      '';
    };
    public.vcsEmail = mkOption {
      type = types.nonEmptyStr;
      default = "ab_contribs@poliorcetiq.eu";
      description = ''
        Email used in commits in public repositories.
      '';
    };

    work.vcsDisplayName = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
      description = ''
        Name used in commits in work repositories.
      '';
    };
    work.vcsEmail = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
      description = ''
        Email used in commits in public repositories.
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.work.vcsDisplayName != null -> cfg.work.vcsEmail != null;
        message = "If `config.personal.work.vcsDisplayName` is set, `config.personal.work.vcsEmail` must be too";
      }
      {
        assertion = cfg.work.vcsEmail != null -> cfg.work.vcsDisplayName != null;
        message = "If `config.personal.work.vcsEmail` is set, `config.personal.work.vcsDisplayName` must be too";
      }
    ];
  };
}
