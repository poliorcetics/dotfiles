# Nushell setup
#
# <https://nushell.sh>
#
# <https://nix-community.github.io/home-manager/options.xhtml#opt-programs.nushell.enable> is not
# used because I don't want any generated file for Nushell: I manage my config using `mkOutOfStoreSymlink`
# instead, and bash/zsh are the one managed through automatic Home Manager file generation.
#
# Also, on macOS it will create its config file in `~/Library/Application Support/nushell` whereas
# I prefer them in `~/.config/nushell`.
#
# Additionally, for `atuin`, `starship`, `zoxide` and other such programs that need an extra file to
# source, the default `<prog>.nix` will recreate the file on each new shell, e.g.:
# <https://github.com/nix-community/home-manager/blob/5b9156fa9a8b8beba917b8f9adbfd27bf63e16af/modules/programs/atuin.nix#L133>
# which is very slow and should not be done that way (instead a `home.activation` script would
# probably be preferable, I should make a PR for that)
{
  config,
  mkProgramFile,
  unstablePkgs,
  ...
}:

{
  imports = [
    (mkProgramFile { } "nushell" "config.nu")
    # Do it per-file to allow for `work/home` to also add its own autoload stuff
    (mkProgramFile { } "nushell" "autoload/commands.nu")
    (mkProgramFile { } "nushell" "autoload/less-env.nu")
  ];

  programs.nushell.package = unstablePkgs.nushell;

  home.packages = [
    config.programs.nushell.package
  ];
}
