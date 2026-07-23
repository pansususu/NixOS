{ config, pkgs, lib, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    enable = true;
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  hardware.firmware = [ pkgs.linux-firmware ];
}
