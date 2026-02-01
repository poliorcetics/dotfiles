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
  completions = "${config.xdg.configHome}/fish/completions";
  inits = "${config.xdg.configHome}/fish/inits";

  atuin = lib.getExe config.programs.atuin.package;
  fish = lib.getExe config.programs.fish.package;
  starship = lib.getExe config.programs.starship.package;
  zoxide = lib.getExe config.programs.zoxide.package;

  downloaded-completions = pkgs.writeShellApplication {
    name = "downloaded-completions";
    runtimeInputs = [
      config.programs.fish.package

      pkgs.curl
      pkgs.mktemp
    ];
    text = ''
      fish ${./downloaded-completions.fish} ${completions}
    '';
  };
in
{
  programs.fish.package = unstablePkgs.fish;

  personal.links = {
    "fish/config.fish" = "modules/hm-program-fish/config.fish";
  };

  programs.bash.initExtra = /* bash */ ''
    # Replace the default shell with fish without overriding with `chsh` to keep a POSIX compatible
    # shell there for programs expecting one
    builtin exec ${fish}
  '';

  home.packages = [
    config.programs.fish.package

    pkgs.eza
    pkgs.fish-lsp

    downloaded-completions
  ];

  # IMPORTANT: when adding here, be sure to source in `config.fish`
  home.activation.installFishCompletions = /* bash */ ''
    run mkdir -p ${inits}

    run ${atuin}    init fish > ${inits}/atuin.fish
    run ${starship} init fish > ${inits}/starship.fish
    run ${zoxide}   init fish > ${inits}/zoxide.fish

    run mkdir -p ${completions}
    run ${atuin}    gen-completions --shell fish > ${completions}/atuin.fish
    run ${starship} completions fish             > ${completions}/starship.fish

    run ${lib.getExe downloaded-completions}
  '';
}
