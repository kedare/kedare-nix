{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/servers/default.nix
    ../../modules/devenv/default.nix
  ];

  networking.hostName = "esbcn1-lab-nixos1";
  time.timeZone = "Europe/Madrid";
}
