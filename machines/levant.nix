{
  home-manager,
  nixpkgs,
  nixpkgs-unstable,
  ...
}:
let
  hostname = "levant";
  username = "alexis";

  machine = "${username}@${hostname}";

  system = "aarch64-linux";

  unstablePkgs = import nixpkgs-unstable {
    inherit system;
  };
in
{
  homeConfigurations.${machine} = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    modules = [
      (import ../modules/home-manager/packages unstablePkgs)
      (import ../modules/home-manager/program-atuin { inherit unstablePkgs; })
      (import ../modules/home-manager/program-fish { inherit unstablePkgs; })
      (import ../modules/home-manager/program-jj { inherit unstablePkgs; })
      (import ../modules/shared/nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })
      (import ../modules/shared/personal-user.nix "linux")

      ../modules/home-manager/activation.nix
      ../modules/home-manager/config-links.nix
      ../modules/home-manager/generic.nix
      ../modules/home-manager/global-package.nix
      ../modules/home-manager/program-bat
      ../modules/home-manager/program-direnv
      ../modules/home-manager/program-gh
      ../modules/home-manager/program-git
      ../modules/home-manager/program-helix
      ../modules/home-manager/program-kitty
      ../modules/home-manager/program-niri
      ../modules/home-manager/program-npm
      ../modules/home-manager/program-python
      ../modules/home-manager/program-shell
      ../modules/home-manager/program-starship
      ../modules/home-manager/program-topgrade
      ../modules/home-manager/program-zoxide
      ../modules/home-manager/variables.nix
      ../modules/home-manager/xdg.nix
      ../modules/shared/nix-gc.nix
      ../modules/shared/nix-package.nix
      ../modules/shared/nix-settings.nix

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
