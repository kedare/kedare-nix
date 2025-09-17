{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/desktop/default.nix
  ];

  networking.hostName = "garuda";
  time.timeZone = "Europe/Madrid";

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/cb377952-64ba-41b3-81a6-fdb810ea5b55";
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
