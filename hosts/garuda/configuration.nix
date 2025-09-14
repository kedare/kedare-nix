{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/desktop/default.nix
    ../../modules/devenv/default.nix
    ../../modules/gaming/default.nix
  ];

  networking.hostName = "garuda";
  time.timeZone = "Europe/Madrid";

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/aad1e5c7-af2b-4d88-b50d-8986c6dc3092";
      preLVM = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

}
