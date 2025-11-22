{
  # Default shell on macOS
  programs.zsh.enable = true;

  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/security/pam.nix>
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
