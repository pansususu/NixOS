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
      url = "git+https://codeberg.org/wh1tepearl/vxwm.git";
      flake = false;
    };
    oxwm.url = "github:tonybanters/oxwm";
  };

  outputs = { self, nixpkgs, spicetify-nix, noctalia, silentSDDM, home-manager, oxwm, ... }@inputs: {
    nixosConfigurations.finix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.spicetify
        silentSDDM.nixosModules.default
        ./modules/vxwm.nix
        ./modules/oxwm.nix
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
