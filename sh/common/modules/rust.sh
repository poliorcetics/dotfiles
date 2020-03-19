# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if test -z ${CARGO_HOME+x}; then
  CARGO_HOME=$DIRCONFIG/rust/cargo
  export $CARGO_HOME
fi
if test -z ${RUSTUP_HOME+x}; then
  RUSTUP_HOME=$DIRCONFIG/rust/rustup
  export $RUSTUP_HOME
fi

# Only setup the aliases if cargo is installed
if test -f $CARGO_HOME/bin/cargo -a -x $CARGO_HOME/bin/cargo; then
  alias cn='cargo new'
  alias cl='cargo clean'
  alias cf='cargo fmt'

  alias cb='cargo build'
  alias ct='cargo test'
  alias cr='cargo run'
  alias cx='cargo check'

  alias cbr='cargo build --release'
  alias ctr='cargo test --release'
  alias crr='cargo run --release'
  alias cxr='cargo check --release'

  alias crq='cargo run --quiet'
  alias ctq='cargo test --quiet'

  alias crrq='cargo run --release --quiet'
  alias ctrq='cargo test --release --quiet'

  case :$PATH: in
    *:$CARGO_HOME/bin:*)
      ;;
    *)
      PATH=$PATH:$CARGO_HOME/bin
      export PATH
      ;;
  esac
else
  echo "Tried to load module for 'rust' but $CARGO_HOME/bin/cargo does not exists." >&2
  echo "Use the command available at https://rustup.rs to install Rust." >&2
  echo "To ensure maximal compatibility with this dotfiles, install: " >&2
  echo "  'cargo' in $CARGO_HOME (create the directories if necessary)" >&2
  echo "  'rustup' in $RUSTUP_HOME (create the directories if necessary)" >&2
  # Avoid polluting the namespace once the error message has run its course
  unset CARGO_HOME
  unset RUSTUP_HOME
fi
