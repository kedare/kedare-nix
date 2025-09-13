{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nixos/default.nix
  ];

  networking.hostName = "esbcn1-lab-nixos1";
  time.timeZone = "Europe/Madrid";
}
