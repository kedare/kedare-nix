{ ... }:

{
  imports = [
    ../global/default.nix
  ];

  networking.networkmanager.connectionConfig = {
    "ipv6.addr-gen-mode" = "euid64";
  };
}
