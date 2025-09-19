{ ... }:

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
      substituters = [
        "http://cache.nix.keda.re"
      ];
    };
  };
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  i18n.defaultLocale = "en_US.UTF-8";

  #nix = {
  #  settings = {
  #    substituters = [
  #      "https://cache.nix.keda.re"
  #      "https://nix-community.cachix.org"
  #    ];
  #    trusted-public-keys = [
  #      "cache.nix.keda.re:vNAsdJFJps8V/EtVdCJxt3ugpiIBfDUyd/WbjhohK7c="
  #      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #    ];
  #  };
  #  buildMachines = {
  #    "esbcn1-nix-cache1" = {
  #      system = "x86_64-linux";
  #      sshUser = "kedare";
  #      sshKey = "/home/kedare/.ssh/id_ed25519";
  #    };
  #  };
  #};

}
