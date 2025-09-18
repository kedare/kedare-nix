{ ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall = {
    allowPing = true;
  };
  services.tailscale.enable = true;
}
