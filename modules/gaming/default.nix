{ pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    heroic
  ];
}
