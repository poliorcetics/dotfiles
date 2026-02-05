{ nixpkgs-unstable, ... }@inputs:
system:
let
  unstablePkgs = import nixpkgs-unstable {
    inherit system;
  };

  # ===============================================================================================
  # SYSTEM LEVEL
  # ===============================================================================================

  # Modules to apply only when using nix-darwin
  #
  # They are not in `systemModules` because they use options that are only defined by nix-darwin
  # and will error out when used on regular nixos systems.
  darwinModules' = [
    ./darwin/defaults.nix
    ./darwin/homebrew.nix
    ./darwin/nix-gc.nix
    ./darwin/security.nix
    ./darwin/system.nix
  ];

  # Modules to apply at the system level (nixos and nix-darwin) configurations
  systemModules = [
    ./system/nix-settings.nix
    ./system/user.nix

    (import ./system/system.nix inputs.self)

    { nixpkgs.hostPlatform = system; }
  ];

  # ===============================================================================================
  # MIXED LEVEL
  # ===============================================================================================

  # Modules to apply in **both** home-manager and system level (nixos and nix-darwin) configurations
  sharedModules = [
    ./shared/personal-user.nix
  ];

  # Modules to apply in **either** home-manager and system level (nixos and nix-darwin) configurations
  #
  # If they're applied in both they lead to double definitions and conflicts.
  eitherModules = [
    ./either/nix-package.nix

    ./either/nix-gc.nix
    ./either/nix-settings.nix

    (import ./either/nix-registry.nix inputs)
  ];

  # ===============================================================================================
  # HOME MANAGER LEVEL
  # ===============================================================================================

  # Modules to apply to home-manager
  homeManagerModules' = [
    ./home-manager/activation.nix
    ./home-manager/config-links.nix
    ./home-manager/generic.nix
    ./home-manager/global-package.nix
    ./home-manager/variables.nix
    ./home-manager/xdg.nix

    (import ./home-manager/packages unstablePkgs)

    (import ./home-manager/program-atuin unstablePkgs)
    (import ./home-manager/program-fish unstablePkgs)
    (import ./home-manager/program-jj unstablePkgs)

    ./home-manager/program-bat
    ./home-manager/program-direnv
    ./home-manager/program-gh
    ./home-manager/program-git
    ./home-manager/program-helix
    ./home-manager/program-kitty
    ./home-manager/program-niri
    ./home-manager/program-npm
    ./home-manager/program-python
    ./home-manager/program-shell
    ./home-manager/program-starship
    ./home-manager/program-topgrade
    ./home-manager/program-zoxide
  ];
in
{
  darwin = {
    systemModules = sharedModules ++ eitherModules ++ systemModules ++ darwinModules';
    homeManagerModules = sharedModules ++ homeManagerModules';
  };

  nixos = {
    systemModules = sharedModules ++ systemModules;
    homeManagerModules = sharedModules ++ homeManagerModules';
  };

  # To use when there is **no** enclosing system
  homeManagerModulesOnly = sharedModules ++ eitherModules ++ homeManagerModules';
}
