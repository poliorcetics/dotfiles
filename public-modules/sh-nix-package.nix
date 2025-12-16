{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.personal) nixFlavor;
  lixVersion = "latest";
in
{
  config = lib.mkMerge [
    (lib.mkIf (nixFlavor == "lix") {
      nixpkgs.overlays = [
        # <https://lix.systems/add-to-config/#advanced-change>
        (_final: prev: {
          inherit (prev.lixPackageSets.${lixVersion})
            colmena
            nix-eval-jobs
            nix-fast-build
            nixpkgs-review
            ;
        })
      ];

      nix.package = pkgs.lixPackageSets.${lixVersion}.lix;
    })

    (lib.mkIf (nixFlavor == "nix") {
      nix.package = pkgs.nix;
    })
  ];
}
