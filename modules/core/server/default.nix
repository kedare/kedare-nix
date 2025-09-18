{ ... }:

{
  imports = [
    ../global/default.nix
  ];

  #networking.networkmanager.connectionConfig = {
  #  "ipv6.ip6-privacy" = "0";
  #};

  networking.tempAddresses = "disabled";
}
