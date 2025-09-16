{ ... }:

{
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  i18n.defaultLocale = "en_US.UTF-8";
}
