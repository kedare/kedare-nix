{
  description = "Kedare NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs, ... }:
    {
      nixosConfigurations = {
        esbcn1_lab_nixos1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/esbcn1-lab-nixos1/configuration.nix
          ];
        };
        garuda = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/garuda/configuration.nix
          ];
        };
      };
    };
}
