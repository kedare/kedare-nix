{ ... }:

{
  imports = [
    ../global/default.nix
  ];

  # Servers are using systemd-network
  systemd.network.enable = true;
  networking.useNetworkd = true;
  networking.tempAddresses = "disabled";
}
