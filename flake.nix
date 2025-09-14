{
  description = "Kedare NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      ...
    }:
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
            nixos-hardware.nixosModules.framework-13-7040-amd
          ];
        };
      };
    };
}
