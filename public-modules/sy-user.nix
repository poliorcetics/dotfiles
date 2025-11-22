{
  home,
  username,
}:
{
  users.users.${username} = {
    inherit home;
    name = username;
  };
}
