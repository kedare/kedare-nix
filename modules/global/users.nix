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
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys =
      let
        authorizedKeys = pkgs.fetchurl {
          url = "https://codeberg.org/kedare.keys";
          sha256 = "sha256-4Y8H2fgNFEJXGKdWjJq5O9AcFoUxjJnWIh6xdqMfo4s=";
        };
      in
      pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);

  };
}
