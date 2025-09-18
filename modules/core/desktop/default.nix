{ ... }:

{
  imports = [
    ../global/default.nix
    ./plymouth.nix
    ./gnome.nix
    ./printing.nix
    ./locales.nix
    ./fingerprint.nix
    ./tools.nix
  ];

  # Desktops/laptops use Network Manager
  networking.networkmanager.enable = true;
}
