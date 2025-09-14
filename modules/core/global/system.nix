{ ... }:

{
  system.stateVersion = "25.05";
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
}
