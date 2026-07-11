# Scripts to run on `home-manager switch`
{
  lib,
  ...
}:
{
  # Create my expected directories
  home.activation.makeDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] /* bash */ ''
    run mkdir -p ~/repos/me/
    run mkdir -p ~/repos/tp/
    run mkdir -p ~/repos/work/
  '';
}
