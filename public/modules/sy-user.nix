{
  config,
  ...
}:
{
  users.users.${config.personal.username} = {
    inherit (config.personal) home;
    name = config.personal.username;
  };
}
