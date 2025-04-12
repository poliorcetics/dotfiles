{
  imports = [
    ./defaults.nix
    ./homebrew.nix
    ./nix.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Default shell on macOS
  programs.zsh.enable = true;

  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-24.11/modules/security/pam.nix>
  security.pam.enableSudoTouchIdAuth = true;
  # Future format:
  # security.pam.services.sudo_local = {
  #   touchIdAuth = true;
  #   watchIdAuth = true;
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-24.11/modules/system/version.nix#L34>
  system.stateVersion = 4;
}
