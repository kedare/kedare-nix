{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    X11Forwarding = false;
  };
}
