{ lib, pkgs, ... }:
{
  # Overrides a binary provided by Nix with one that ends up later in the $PATH order:
  #
  # ```nix
  # overrideNixProvideBinary "hx" (lib.getExe config.programs.helix.package) "${config.home.sessionVariables.CARGO_HOME}/bin/hx";
  # ```
  overrideNixProvidedBinary =
    name: nix_pkg: replacement_path:
    (lib.hiPrio (
      pkgs.writeShellScriptBin name ''
        if test -x "${replacement_path}"; then
          "${replacement_path}" "$@"
        else
          "${nix_pkg}" "$@"
        fi
      ''
    ));

}
