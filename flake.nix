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
        esbcn1-lab-nixos1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/esbcn1-lab-nixos1/configuration.nix
          ];
        };
        esbcn1-nas1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/esbcn1-nas1/configuration.nix
          ];
        };
        garuda = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/garuda/configuration.nix
            nixos-hardware.nixosModules.framework-13-7040-amd
          ];
        };
        carbuncle = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/carbuncle/configuration.nix
          ];
        };
        bahamut = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/bahamut/configuration.nix
          ];
        };
      };
    };
}
