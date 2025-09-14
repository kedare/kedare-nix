{ ... }:

{
  imports = [
    ../global/default.nix
    ./plymouth.nix
    ./gnome.nix
    ./fingerprint.nix
    ./tools.nix
  ];
}
