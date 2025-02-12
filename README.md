# Dotfiles

The objective is to use [`home-manager`](https://nix-community.github.io/home-manager/index.xhtml) to manage my dotfiles. Let's hope this time I don't end up with a broken management system in a few months.

## TODOS

 - Update command now that I moved to nix-darwin
 - Redo install procedure to use setup.sh

## Install procedure

I use [`nushell`](https://www.nushell.sh/) as my primary shell but I do **not** set it as the default shell for my user (no `chsh`) to avoid issues with programs that expect the default shell to be `bash`-like. I simply launch `nushell` from the `.bashrc` or `.zshrc` in interactive mode.

Anyway, onwards to the installation:

```sh
# 0. Install dev tools
xcode-select --install

# 1. Install nix (package manager)
#
# See: https://nixos.org/download
bash <(curl -L https://nixos.org/nix/install) --daemon

# 2. Add unstable and home-manager channels
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
# See: https://nix-community.github.io/home-manager/#sec-install-standalone
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# 3. Install home-manager
nix-shell '<home-manager>' -A install

# 4. Open a nix-shell with git to clone this config
nix-shell -p git
mkdir -p ~/repos/me/
cd ~/repos/me/
git clone https://github.com/poliorcetics/dotfiles.git
exit

# 5. Replaces the default home-manager config with the one from the `dotfiles` repository
rm ~/.config/home-manager/home.nix
rmdir ~/.config/home-manager/
ln -s $HOME/repos/me/dotfiles $HOME/.config/home-manager

# 6. Fix the user infos
sed -i -E "s:home.username = \".*\";:home.username = \"$USER\";:" ~/.config/home-manager
sed -i -E "s:home.homeDirectory = \".*\";:home.homeDirectory = \"$HOME\";:" ~/.config/home-manager

# 7. Compile home-manager setup
home-manager switch

# 8.pre. Do the homebrew installation, see below

# 8. In a new terminal
~/.local/bin/hm.nu rust installs # Custom rust program installs
~/.local/bin/hm.nu iosevka build # Custom font

# 9. Generate new SSH keys for authentication and signing
#
# Add to GitHub: <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "COMMENT"
ssh-keygen -t ed25519 -f ~/.ssh/id_signing -C "COMMENT - Signing"

ssh-agent -s
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
ssh-add --apple-use-keychain ~/.ssh/id_signing

# 10. Sync Atuin
#
# Docs: <https://docs.atuin.sh/guide/sync/#login>
atuin login -u "<USER>"
atuin sync -f
```

### macOS apps

On macOS, I like installing a few more apps. Since it's annoying to do it manually then track them for updates, I use [`homebrew`](https://brew.sh/):

```sh
~/.local/bin/hm.nu brew init
~/.local/bin/hm.nu tm setup-exclusions
```

I could use `home-manager` for some of those, but it doesn't sign nor install them in `/Applications` correctly so I prefer not to.

### After the install

- Connect Matrix account
