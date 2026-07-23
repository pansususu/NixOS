{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/sddm.nix
  ];

  system.stateVersion = "26.11";
  nixpkgs.config.allowUnfree = true;
}
