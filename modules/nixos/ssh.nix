{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "no";
      passwordAuthentication = false;
      X11Forwarding = false;
    };
  };
}
