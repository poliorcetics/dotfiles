{
  home-manager,
  nix-darwin,
  nixpkgs,
  nixpkgs-unstable,
  self,
  ...
}:
let
  hostname = "ponant";

  system = "aarch64-darwin";

  unstablePkgs = import nixpkgs-unstable {
    inherit system;
  };
in
rec {
  darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      home-manager.darwinModules.home-manager

      (import ../../modules/sh-personal-user.nix "darwin")

      (import ../../modules/sh-nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })
      ../../modules/sh-nix-gc.nix
      ../../modules/sh-nix-package.nix
      ../../modules/sh-nix-settings.nix

      (import ../../modules/sy-system.nix { inherit self; })
      ../../modules/sy-nix-settings.nix

      ../../modules/sy-darwin-defaults.nix
      ../../modules/sy-darwin-homebrew.nix
      ../../modules/sy-darwin-nix-gc.nix
      ../../modules/sy-darwin-security.nix
      ../../modules/sy-darwin-system.nix

      ../../modules/sy-user.nix

      { nixpkgs.hostPlatform = system; }

      # <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module>
      (
        {
          config,
          ...
        }:
        {
          # <https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useGlobalPkgs>
          home-manager.useGlobalPkgs = true;
          # Don't allow `users.users.<name>.packages = [ ... ]`, it avoids surprises like adding a
          # package for only one user.
          # <https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useUserPackages>
          home-manager.useUserPackages = false;

          home-manager.users.${config.personal.username}.imports = [
            (import ../../modules/sh-personal-user.nix "darwin")

            (import ../../modules/hm-packages unstablePkgs)
            ../../modules/hm-activation
            ../../modules/hm-config-links.nix
            ../../modules/hm-generic.nix
            ../../modules/hm-global-package.nix

            (import ../../modules/hm-program-atuin { inherit unstablePkgs; })
            (import ../../modules/hm-program-jj { inherit unstablePkgs; })
            (import ../../modules/hm-program-nushell { inherit unstablePkgs; })
            ../../modules/hm-program-bat
            ../../modules/hm-program-direnv
            ../../modules/hm-program-gh
            ../../modules/hm-program-git
            ../../modules/hm-program-helix
            ../../modules/hm-program-kitty
            ../../modules/hm-program-niri
            ../../modules/hm-program-npm
            ../../modules/hm-program-python
            ../../modules/hm-program-shell
            ../../modules/hm-program-starship
            ../../modules/hm-program-topgrade
            ../../modules/hm-program-zoxide

            ../../modules/hm-variables.nix
            ../../modules/hm-xdg.nix
          ];
        }
      )
    ];
  };

  checks.${system}.${hostname} = darwinConfigurations.${hostname}.system;
}
