{
  home-manager,
  nix-darwin,
  ...
}@inputs:
let
  hostname = "ponant";

  system = "aarch64-darwin";

  allModules = import ../modules/all-modules.nix inputs system;
in
{
  darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      home-manager.darwinModules.home-manager
    ]
    ++ allModules.darwin.systemModules
    ++ [
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

          home-manager.users.${config.personal.username}.imports = allModules.darwin.homeManagerModules ++ [
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
