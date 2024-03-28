# Starship configuration
#
# <https://starship.rs>

{ lib, ... }:
{
  programs.starship.enable = true;

  # Settings: <https://starship.rs/config/>
  programs.starship.settings = {
    format = lib.concatStrings [
      "$time"
      "$username"
      "$hostname"
      "$directory"
      "$git_branch"
      "$git_state"
      "$git_status"
      "$python"
      "$rust"
      "$cmd_duration"
      "$nix_shell"
      "$line_break"
      "$jobs"
      "$shell"
      "$status"
      "$character"
    ];

    command_timeout = 100;

    # Active modules

    character = {
      error_symbol = "[✖](bold red)";
      success_symbol = "[❯](bold green)";
    };

    cmd_duration = {
      show_milliseconds = true;
      style = "yellow";
    };

    nix_shell = {
      format = "via [$symbol$state( \\($name\\))]($style) ";
      symbol = "❄️ ";
      disabled = false;
    };

    directory = {
      style = "cyan";
      repo_root_style = "bold cyan";
      truncation_length = 1;
      fish_style_pwd_dir_length = 1;
    };

    git_branch = {
      format ="[$symbol$branch(:$remote_branch)]($style) ";
      style = "purple";
    };

    package = {
      style = "208";
    };

    python = {
      python_binary = "python3";
      style = "yellow";
    };

    rust = {
      style = "red";
      disabled = true;
    };

    git_state = {
      disabled = false;
    };

    git_status = {
      disabled = false;
      style = "yellow";
      stashed = "";
    };

    shell = {
      bash_indicator = "b";
      zsh_indicator = "z";
      fish_indicator = "🐠";
      nu_indicator = "🐘";
      disabled = false;
    };

    status = {
      format = "[$status]($style) ";
      disabled = false;
    };

    time = {
      format = "[$time]($style) ";
      style = "italic white";
      disabled = false;
    };

    # Disabled modules
    aws.disabled = true;
    battery.disabled = true;
    buf.disabled = true;
    bun.disabled = true;
    c.disabled = true;
    cmake.disabled = true;
    cobol.disabled = true;
    conda.disabled = true;
    container.disabled = true;
    crystal.disabled = true;
    daml.disabled = true;
    dart.disabled = true;
    deno.disabled = true;
    direnv.disabled = true;
    docker_context.disabled = true;
    dotnet.disabled = true;
    elixir.disabled = true;
    elm.disabled = true;
    env_var.disabled = true;
    erlang.disabled = true;
    fennel.disabled = true;
    fill.disabled = true;
    fossil_branch.disabled = true;
    fossil_metrics.disabled = true;
    gcloud.disabled = true;
    git_commit.disabled = true;
    git_metrics.disabled = true;
    golang.disabled = true;
    guix_shell.disabled = true;
    gradle.disabled = true;
    haskell.disabled = true;
    haxe.disabled = true;
    helm.disabled = true;
    java.disabled = true;
    julia.disabled = true;
    kotlin.disabled = true;
    kubernetes.disabled = true;
    localip.disabled = true;
    lua.disabled = true;
    memory_usage.disabled = true;
    meson.disabled = true;
    hg_branch.disabled = true;
    nim.disabled = true;
    nodejs.disabled = true;
    ocaml.disabled = true;
    opa.disabled = true;
    openstack.disabled = true;
    os.disabled = true;
    package.disabled = true;
    perl.disabled = true;
    php.disabled = true;
    pijul_channel.disabled = true;
    pulumi.disabled = true;
    purescript.disabled = true;
    rlang.disabled = true;
    raku.disabled = true;
    red.disabled = true;
    ruby.disabled = true;
    scala.disabled = true;
    shlvl.disabled = true;
    singularity.disabled = true;
    solidity.disabled = true;
    spack.disabled = true;
    sudo.disabled = true;
    swift.disabled = true;
    terraform.disabled = true;
    typst.disabled = true;
    vagrant.disabled = true;
    vlang.disabled = true;
    vcsh.disabled = true;
    zig.disabled = true;
  };
}
