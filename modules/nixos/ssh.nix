{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    usePAM = true;
    x11Forwarding = false;
  };
}
