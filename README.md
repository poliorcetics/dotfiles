# Dotfiles

The objective is to use [`home-manager`](https://nix-community.github.io/home-manager/index.xhtml) to manage my dotfiles. Let's hope this time I don't end up with a broken management system in a few months.

## Install procedure

I use [`fish`](https://fishshell.com/) as my primary shell but I do **not** set it as the default shell for my user (no `chsh`) to avoid issues with programs that expect the default shell to be `bash`-like. I simply launch it from the `.bashrc` or `.zshrc` in interactive mode.

Anyway, onwards to the installation:

### Linux

1. Install [`lix`](https://lix.systems) or [`nix`](https://nixos.org)
1. Temporarily install Git `nix shell nixpkgs#git`
1. `./dotfiles.sh update`

### macOS

```sh
## Initial install
./dotfiles.sh initial-setup

## OPEN A NEW TERMINAL

## Install everything
./dotfiles.sh update
```

### Common

```sh
## Secondary setup, after installing the requirement just above
./dotfiles.sh secondary-setup

## Generate new SSH keys for authentication and signing
#
# Add to GitHub: <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "COMMENT"
ssh-keygen -t ed25519 -f ~/.ssh/id_signing -C "COMMENT - Signing"

## Sync Atuin
#
# Docs: <https://docs.atuin.sh/guide/sync/#login>
atuin login -u "<USER>"
atuin sync -f
```

### After the install

- Connect Matrix account
- Firefox extensions (TST and `userChrome.css` notably)
