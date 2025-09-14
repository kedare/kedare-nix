{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/server/default.nix
    ../../modules/devenv/default.nix
  ];

  networking.hostName = "esbcn1-lab-nixos1";
  time.timeZone = "Europe/Madrid";
}
