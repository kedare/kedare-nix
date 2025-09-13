{
  pkgs,
  ...
}:

{
  users.users.kedare = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = "/usr/bin/zsh";

    openssh.authorizedKeys.keys =
      let
        authorizedKeys = pkgs.fetchurl {
          url = "https://codeberg.org/kedare.keys";
          sha256 = "sha256-Rq3Ln0+4ss+oRc9bLnAM027OmXRYlH6KfYycHrlY/es=";
        };
      in
      pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);

  };
}
