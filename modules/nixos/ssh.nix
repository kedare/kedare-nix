{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    usePAM = true;
    allowTcpForwarding = true;
    x11Forwarding = false;
    printMotd = false;
    clientAliveInterval = 300;
    clientAliveCountMax = 2;
  };
}
