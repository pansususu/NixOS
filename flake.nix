{
  description = "Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, spicetify-nix }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        { _module.args = { inherit inputs; }; }
        spicetify-nix.nixosModules.spicetify
      ];
    };
  };
}
