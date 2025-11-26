{
  home-manager,
  nix-darwin,
  nixpkgs,
  nixpkgs-unstable,
  self,
  ...
}@inputs:
system:
let
  platform =
    {
      aarch64-darwin = "darwin";
      aarch64-linux = "linux";
    }
    .${system};

  unstablePkgs = import nixpkgs-unstable {
    inherit system;
  };

  workModules =
    (
      if builtins.pathExists ./work-modules/default.nix then
        (import ./work-modules/default.nix inputs { inherit platform system unstablePkgs; })
      else
        { }
    )
    // {
      sharedModules = [ ];
      systemModules = [ ];
      darwinSystemModules = [ ];
      hmModules = [ ];
      darwinHmModules = [ ];
      linuxHmModules = [ ];
    };

  # This module is special in that it is not imported via `sharedModules` but instead via
  # both `systemModules` and `hmModules` since we need the values in it in both cases.
  personalUserModule = import ./public-modules/sh-personal-user.nix platform;

  sharedModules = [
    (import ./public-modules/sh-nix-registry.nix { inherit nixpkgs nixpkgs-unstable; })

    ./public-modules/sh-nix-gc.nix
    ./public-modules/sh-nix-package.nix
    ./public-modules/sh-nix-settings.nix
  ]
  ++ workModules.sharedModules;

  systemModules = [
    { nixpkgs.hostPlatform = system; }

    personalUserModule

    (import ./public-modules/sy-system.nix { inherit self; })

    ./public-modules/sy-nix-settings.nix
    ./public-modules/sy-user.nix
  ]
  ++ sharedModules
  ++ workModules.systemModules;

  darwinSystemModules =
    systemModules
    ++ [
      ./public-modules/sy-darwin-defaults.nix
      ./public-modules/sy-darwin-homebrew.nix
      ./public-modules/sy-darwin-nix-gc.nix
      ./public-modules/sy-darwin-security.nix
      ./public-modules/sy-darwin-system.nix
    ]
    ++ workModules.darwinSystemModules;

  # Home Manager config
  #
  # Main documentation: <https://nix-community.github.io/home-manager/index.xhtml>
  # All options: <https://nix-community.github.io/home-manager/options.xhtml>
  hmModules = [
    personalUserModule

    (import ./public-modules/hm-packages unstablePkgs)

    ./public-modules/hm-activation
    ./public-modules/hm-config-links.nix
    ./public-modules/hm-generic.nix
    ./public-modules/hm-variables.nix
    ./public-modules/hm-xdg.nix

    (import ./public-modules/hm-program-atuin { inherit unstablePkgs; })
    (import ./public-modules/hm-program-jj { inherit unstablePkgs; })
    (import ./public-modules/hm-program-nushell { inherit unstablePkgs; })

    ./public-modules/hm-program-bat
    ./public-modules/hm-program-direnv
    ./public-modules/hm-program-gh
    ./public-modules/hm-program-git
    ./public-modules/hm-program-helix
    ./public-modules/hm-program-kitty
    ./public-modules/hm-program-npm
    ./public-modules/hm-program-python
    ./public-modules/hm-program-starship
    ./public-modules/hm-program-topgrade
    ./public-modules/hm-program-shell
    ./public-modules/hm-program-zoxide
  ]
  ++ workModules.hmModules;

  darwinHmModules = hmModules ++ workModules.darwinHmModules;

  linuxHmModules = sharedModules ++ hmModules ++ workModules.linuxHmModules;

  darwinFullSystem = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = darwinSystemModules ++ [
      home-manager.darwinModules.home-manager

      # Configure home-manager to pick up both the public and work configurations (if they exist)
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

          home-manager.users.${config.personal.username}.imports = darwinHmModules;
        }
      )
    ];
  };

  linuxHmSystem = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs { inherit system; };
    modules = linuxHmModules;
  };

  finalSystem =
    {
      darwin = darwinFullSystem;
      linux = linuxHmSystem;
    }
    .${platform};
in
finalSystem
