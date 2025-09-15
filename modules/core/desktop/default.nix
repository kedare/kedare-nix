{ ... }:

{
  imports = [
    ../global/default.nix
    ./plymouth.nix
    ./gnome.nix
    ./locales.nix
    ./fingerprint.nix
    ./tools.nix
  ];
}
