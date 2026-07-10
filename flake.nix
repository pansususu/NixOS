{
  description = "Finix - flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    finix.url = "github: FixeQD:finix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, finix, spicetify-nix, ... }@inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.finix = finix.lib.finixSystem {
      inherit (pkgs) lib;

      modules = with finix.nixosModules; [
        {
          nixpkgs.pkgs = nixpkgs.lib.mkDefault pkgs;
        }
        ./configuration.nix
        { _module.args = { inherit inputs; }; }
        spicetify-nix.nixosModules.spicetify
        nix-daemon
        openssh
        sysklogd
        limine
        sudo
        polkit
        getty
        bash
        networkmanager
        ly
        xorg
        flatpak
        pipewire
      ];

      specialArgs = {
        modulesPath = toString nixpkgs + "/nixos/modules";
      };
    };
  };
}
