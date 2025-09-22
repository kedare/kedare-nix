{ ... }:

{
  imports = [
    ../global/default.nix
    ./plymouth.nix
    ./gnome.nix
    ./audio.nix
    ./printing.nix
    ./locales.nix
    ./fingerprint.nix
    ./tools.nix
  ];

  # Desktops/laptops use Network Manager
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = true;
      };
      Policy = {
        AutoEnable = "true";
      };
      LE = {
        EnableAdvMonInterleaveScan = "true";
      };
    };
  };
}
