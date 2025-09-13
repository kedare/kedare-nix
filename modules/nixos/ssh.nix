{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    usePAM = true;
    x11Forwarding = false;
    printMotd = false;
    clientAliveInterval = 300;
    clientAliveCountMax = 2;
  };
}
