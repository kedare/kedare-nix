{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/server/default.nix
    ../../modules/devenv/default.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "esbcn1-lab-nixos1";
  time.timeZone = "Europe/Madrid";
}
