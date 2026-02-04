# Fish shell
#
# <https://fishshell.com/docs/>
{ unstablePkgs }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # <https://fishshell.com/docs/current/completions.html#where-to-put-completions>
  completions = "${config.xdg.configHome}/fish/completions";

  # Custom inits to avoid having to generate them every time a shell is opened
  inits = "${config.xdg.cacheHome}/fish/personal";

  fish = lib.getExe config.programs.fish.package;
in
{
  programs.fish = {
    enable = true;
    package = unstablePkgs.fish;
    shellInitLast = /* fish */ ''
      status is-interactive; and begin
        source ${config.xdg.configHome}/fish/extra-config.fish
      end
    '';
  };

  # See `inits` definition above
  programs.atuin.enableFishIntegration = false;
  programs.starship.enableFishIntegration = false;
  programs.zoxide.enableFishIntegration = false;

  personal.links = {
    "fish/extra-config.fish" = "modules/home-manager/program-fish/extra-config.fish";
  };

  programs.bash.initExtra = /* bash */ ''
    # Replace the default shell with fish without overriding with `chsh` to keep a POSIX compatible
    # shell there for programs expecting one
    builtin exec ${fish}
  '';

  home.packages = [
    pkgs.eza
    pkgs.fish-lsp
  ];

  home.activation.installFishScripts = /* bash */ ''
    run mkdir -p ${inits}
    run rm ${inits}/*.fish || true # Ensure no cruft

    # See `inits` definition above
    run ${lib.getExe config.programs.atuin.package}    init fish                   > ${inits}/atuin.fish
    run ${lib.getExe config.programs.starship.package} init fish --print-full-init > ${inits}/starship.fish
    run ${lib.getExe config.programs.zoxide.package}   init fish                   > ${inits}/zoxide.fish

    run mkdir -p ${completions}
    run ${fish} ${./downloaded-completions.fish} ${completions}
  '';
}
