{ config, pkgs, ... }:

{
  programs.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.ly.enable = true;
}
