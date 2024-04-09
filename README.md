# Dotfiles

The objective is to use [`home-manager`](https://nix-community.github.io/home-manager/index.xhtml) to manage my dotfiles. Let's hope this time I don't end up with a broken management system in a few months.

## Install procedure

I use [`nushell`](https://www.nushell.sh/) as my primary shell but I do **not** set it as the default shell for my user (no `chsh`) to avoid issues with programs that expect the default shell to be `bash`-like. I simply launch `nushell` from the `.bashrc` or `.zshrc` in interactive mode.

Anyway, onwards to the installation:

```sh
## Initial install
./dotfiles.sh initial-setup

## OPEN A NEW TERMINAL

## Install everything
./dotfiles.sh update

## Secondary setup, after installing the requirement just above
./dotfiles.sh secondary-setup

## Generate new SSH keys for authentication and signing
#
# Add to GitHub: <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "COMMENT"
ssh-keygen -t ed25519 -f ~/.ssh/id_signing -C "COMMENT - Signing"

ssh-agent -s
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
ssh-add --apple-use-keychain ~/.ssh/id_signing

## Sync Atuin
#
# Docs: <https://docs.atuin.sh/guide/sync/#login>
atuin login -u "<USER>"
atuin sync -f
```

### After the install

- Connect Matrix account
