{ lib, ... }:

{
  system.stateVersion = "25.05";
  nix = {
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 4w";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = lib.mkBefore [
        "https://cache.nix.keda.re"
      ];
    };
  };
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  i18n.defaultLocale = "en_US.UTF-8";
}
