#!/usr/bin/env bash

# Show the script itself to ensure it does what it pretends to do.
/bin/cat "$0"

uname_os="$(/usr/bin/uname -s)"

# Check the system to do some initial install
case "$uname_os" in
    Linux*)
        /bin/echo "Known system: Linux"
        ;;

    Darwin*)
        # Lots of stuff to do on macOS
        /bin/echo "Known system: Darwin"

        # Installing XCode stuff is a requirement
        /bin/echo "xcode-select Install"
        /usr/bin/xcode-select --install

        # Homebrew for proper .app, those from nix are often unsigned and in an unusual place
        /bin/echo "Installing Homebrew"
        /bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # That link can be created before the app is there in theory
        /bin/echo "Linking xterm info for kitty to the default XDG_DATA_HOME"
        link_dir="$HOME/.local/share/terminfo/78"
        /bin/mkdir -p "$link_dir"
        /bin/ln -s /Applications/kitty.app/Contents/Resources/terminfo/78/xterm-kitty "$link_dir/xterm-kitty"
        ;;

    *)
        /bin/echo "Unknown system: $uname_os"
        exit 1
        ;;
esac

/bin/echo "Writing /etc/nix/nix.conf"
/usr/bin/sudo /bin/sh -c "/bin/echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf"
/usr/bin/sudo /bin/sh -c "/bin/echo 'max-jobs = auto' >> /etc/nix/nix.conf"

if ! /usr/bin/which nix &>/dev/null; then
    /bin/echo "Installing nix"
    /bin/sh <(/usr/bin/curl -L https://nixos.org/nix/install) --daemon
fi

case "$uname_os" in
    Linux*)
        /usr/bin/sudo /usr/bin/systemctl restart nix-daemon.service
        ;;

    Darwin*)
        /usr/bin/sudo /bin/launchctl kickstart -k system/org.nixos.nix-daemon
        ;;

    # Should never be taken since we checked earlier for it.
    *)
        /bin/echo "Unknown system: $uname_os"
        exit 1
        ;;
esac
