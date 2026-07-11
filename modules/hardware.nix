{ config, pkgs, lib, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    enable = true;
    modesetting.enable = true;
    kernelModule = "closed";
    powerManagement.enable = false;
  };

  environment.etc."X11/xorg.conf.d/10-nvidia-prime.conf".text = ''
    Section "ServerLayout"
      Identifier "layout"
      Option "AllowEmptyInitialConfiguration"
    EndSection

    Section "Device"
      Identifier "intel"
      Driver "modesetting"
      BusID  "PCI:0:2:0"
    EndSection

    Section "Device"
      Identifier "nvidia"
      Driver "nvidia"
      BusID  "PCI:1:0:0"
      Option "AllowEmptyInitialConfiguration"
    EndSection
  '';

  services.gardendevd.enable = true;

  services.seatd.enable = true;

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  hardware.firmware = [ pkgs.linux-firmware ];
}
