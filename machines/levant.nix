{
  home-manager,
  nixpkgs,
  ...
}@inputs:
let
  hostname = "levant";
  username = "alexis";

  system = "aarch64-linux";

  allModules = import ../modules/all-modules.nix inputs system;
in
{
  homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    modules = allModules.homeManagerModulesOnly ++ [
      # This value determines the Home Manager release that your configuration is compatible
      # with. This  helps avoid breakage when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do want to
      # update the  value, then make sure to first check the Home Manager release notes.
      { home.stateVersion = "25.05"; }
    ];
  };
}
