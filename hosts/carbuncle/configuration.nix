{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/desktop/default.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "garuda";
  time.timeZone = "Europe/Madrid";

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/cb377952-64ba-41b3-81a6-fdb810ea5b55";
      preLVM = true;
    };
  };

  # fix https://discussion.fedoraproject.org/t/certain-apps-not-showing-correctly-after-last-update/155193/20
  environment.variables = {
    GSK_RENDERER = "cairo";
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
