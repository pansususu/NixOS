{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    noctalia.url = "github:noctalia-dev/noctalia";
  };

  outputs = { self, nixpkgs, spicetify-nix, noctalia, ... }@inputs: {
    nixosConfigurations.finix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.spicetify
      ];
    };
  };
}
