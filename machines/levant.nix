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
      (import ../modules/hm-packages unstablePkgs)
      (import ../modules/hm-program-atuin { inherit unstablePkgs; })
      (import ../modules/hm-program-jj { inherit unstablePkgs; })
      (import ../modules/hm-program-nushell { inherit unstablePkgs; })
      (import ../modules/sh-nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })
      (import ../modules/sh-personal-user.nix "linux")

      ../modules/hm-activation
      ../modules/hm-config-links.nix
      ../modules/hm-generic.nix
      ../modules/hm-global-package.nix
      ../modules/hm-program-bat
      ../modules/hm-program-direnv
      ../modules/hm-program-gh
      ../modules/hm-program-git
      ../modules/hm-program-helix
      ../modules/hm-program-kitty
      ../modules/hm-program-niri
      ../modules/hm-program-npm
      ../modules/hm-program-python
      ../modules/hm-program-shell
      ../modules/hm-program-starship
      ../modules/hm-program-topgrade
      ../modules/hm-program-zoxide
      ../modules/hm-variables.nix
      ../modules/hm-xdg.nix
      ../modules/sh-nix-gc.nix
      ../modules/sh-nix-package.nix
      ../modules/sh-nix-settings.nix

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
