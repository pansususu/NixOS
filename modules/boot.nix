{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Zram
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
