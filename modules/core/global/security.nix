{ ... }:

{
  services.fail2ban = {
    enable = true;
    maxretry = 10;
    ignoreIP = [
      "192.168.88.0/22"
      "2001:67c:da8:1000::/60"
    ];
    jails = {
      sshd = {
        enabled = true;
      };
    };
  };
}
