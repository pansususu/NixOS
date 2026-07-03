# ¡THIS IS A CONFIG FOR NVIDIA LAPTOP! (My laptop is ASUS TUF Gaming F15 FX506LH_FX506LH (1.0))

{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix

    # Tus nuevos módulos clonando el estilo de image_499203.png
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/system.nix
    ./modules/users.nix
  ];

  # Flake general settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05"; 
}
