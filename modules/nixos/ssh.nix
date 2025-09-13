{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    x11Forwarding = false;
  };
}
