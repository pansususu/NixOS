{
  description = "Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    singularity-desktop.url = "github:mateoalfaro/singularity-flake";
  };

  outputs = { self, nixpkgs, spicetify-nix, singularity-desktop, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        { _module.args = { inherit inputs; }; }
        spicetify-nix.nixosModules.spicetify
        singularity-desktop.nixosModules.default 
      ];
    };
  };
}
