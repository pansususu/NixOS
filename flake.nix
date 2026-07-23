{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    noctalia.url = "github:noctalia-dev/noctalia";
    silentSDDM.url = "github:uiriansan/SilentSDDM";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vxwm-src = {
      url = "https://codeberg.org/wh1tepearl/vxwm";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, spicetify-nix, noctalia, silentSDDM, home-manager, ... }@inputs: {
    nixosConfigurations.finix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.spicetify
        silentSDDM.nixosModules.default
        ./modules/vxwm.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-backup";
            extraSpecialArgs = { inherit inputs; };
            users.sabrina = import ./modules/home.nix;
          };
        }
      ];
    };
  };
}
