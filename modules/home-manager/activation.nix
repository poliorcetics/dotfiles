# Scripts to run on `home-manager switch`
{
  # Create my expected directories
  home.activation.makeDirs = /* bash */ ''
    run mkdir -p ~/repos/me/
    run mkdir -p ~/repos/tp/
    run mkdir -p ~/repos/work/
  '';
}
