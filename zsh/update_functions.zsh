# UPDATES
# =======

function run_all_completions() {
    swift package completion-tool generate-zsh-script > $DIRCONFIG/zsh/_swift
    rustup completions zsh cargo > $DIRCONFIG/zsh/_cargo
    rustup completions zsh > $DIRCONFIG/zsh/_rustup
    pip3 completion --zsh > $DIRCONFIG/zsh/_pip3
}

function run_all_updates() {
    echo "Updating Homebrew packages"
    echo "=========================="
    echo ""

    bu

    echo ""
    echo "Updating Cargo packages"
    echo "======================="
    echo ""

    cargo install --list | rg '([\w-]+) v\S+:' -r '$1' | xargs cargo install


    echo ""
    echo "Updating Pip packages"
    echo "====================="
    echo ""

    pip3 list | rg '(\S+)\s+\d+.\d+.\d+' -r '$1' | xargs pip3 install --upgrade

    for var in "$@"; do
        case $var in
            "--ra")
                echo ""
                echo "Updating Rust-Analyzer"
                echo "======================"
                echo ""

                ( cd ~/Projects/rust/rust-analyzer \
                    && g checkout master \
                    && g pull \
                    && cg xtask install --server )
                ;;
            "--ru")
                echo ""
                echo "Updating Rust (via Rustup)"
                echo "=========================="
                echo ""
    
               rustup update
               ;;
       esac
    done
}
