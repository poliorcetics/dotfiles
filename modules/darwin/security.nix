{
  # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.11/modules/security/pam.nix>
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
