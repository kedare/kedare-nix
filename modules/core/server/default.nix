{ ... }:

{
  imports = [
    ../global/default.nix
  ];

  # Servers are using systemd-network
  systemd.network.enable = true;
  networking.tempAddresses = "disabled";
}
