{ ... }:

{
  imports = [
    ../../modules/nixos/default.nix
  ];

  networking.hostname = "esbcn1-lab-nixos1";
  time.timeZone = "Europe/Madrid";
}
