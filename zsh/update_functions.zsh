# UPDATES
# =======

function run_all_completions() {
    swift package completion-tool generate-zsh-script > $DIRCONFIG/zsh/_swift
    rustup completions zsh cargo > $DIRCONFIG/zsh/_cargo
    rustup completions zsh > $DIRCONFIG/zsh/_rustup
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

    cg install --list | rg '([\w-]+) v\S+:' -r '$1' | xargs cg install

    for var in "$@"; do
        case $var in
            "--ra")
                echo ""
                echo "Updating Rust-Analyzer"
                echo "======================"
                echo ""

                (  ~/Projects/rust/rust-analyzer \
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
