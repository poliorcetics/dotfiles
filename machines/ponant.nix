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
{
  darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      home-manager.darwinModules.home-manager

      (import ../modules/shared/personal-user.nix "darwin")

      (import ../modules/shared/nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })
      ../modules/shared/nix-gc.nix
      ../modules/shared/nix-package.nix
      ../modules/shared/nix-settings.nix

      (import ../modules/system/system.nix { inherit self; })
      ../modules/system/nix-settings.nix

      ../modules/darwin/defaults.nix
      ../modules/darwin/homebrew.nix
      ../modules/darwin/nix-gc.nix
      ../modules/darwin/security.nix
      ../modules/darwin/system.nix

      ../modules/system/user.nix

      {
        nixpkgs.hostPlatform = system;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/version.nix#L34>
        system.stateVersion = 4;
      }

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
            (import ../modules/shared/personal-user.nix "darwin")

            (import ../modules/home-manager/packages unstablePkgs)
            ../modules/home-manager/activation.nix
            ../modules/home-manager/config-links.nix
            ../modules/home-manager/generic.nix
            ../modules/home-manager/global-package.nix

            (import ../modules/home-manager/program-atuin { inherit unstablePkgs; })
            (import ../modules/home-manager/program-fish { inherit unstablePkgs; })
            (import ../modules/home-manager/program-jj { inherit unstablePkgs; })
            ../modules/home-manager/program-bat
            ../modules/home-manager/program-direnv
            ../modules/home-manager/program-gh
            ../modules/home-manager/program-git
            ../modules/home-manager/program-helix
            ../modules/home-manager/program-kitty
            ../modules/home-manager/program-npm
            ../modules/home-manager/program-python
            ../modules/home-manager/program-shell
            ../modules/home-manager/program-starship
            ../modules/home-manager/program-topgrade
            ../modules/home-manager/program-zoxide

            ../modules/home-manager/variables.nix
            ../modules/home-manager/xdg.nix

            # This value determines the Home Manager release that your configuration is compatible
            # with. This  helps avoid breakage when a new Home Manager release introduces backwards
            # incompatible changes.
            #
            # You should not change this value, even if you update Home Manager. If you do want to
            # update the  value, then make sure to first check the Home Manager release notes.
            { home.stateVersion = "24.05"; }
          ];
        }
      )
    ];
  };
}
