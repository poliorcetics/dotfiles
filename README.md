# Dotfiles

The objective is to use [`home-manager`](https://nix-community.github.io/home-manager/index.xhtml) to manage my dotfiles. Let's hope this time I don't end up with a broken management system in a few months.

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

# 2. Add the home-manager channel
#
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
```

### macOS apps

On macOS, I like installing a few more apps. Since it's annoying to do it manually then track them for updates, I use [`homebrew`](https://brew.sh/):

```sh
~/.local/bin/hm.nu brew init
~/.local/bin/hm.nu tm setup-exclusions
```

I could use `home-manager` for some of those, but it doesn't sign nor install them in `/Applications` correctly so I prefer not to.
