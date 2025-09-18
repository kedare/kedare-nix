{ ... }:
{
  networking.firewall = {
    allowPing = true;
  };
  services.tailscale.enable = true;
}
