{ config, pkgs, ... }:

{
  networking.hostName = "finix";
  services.networkmanager.enable = true;

  services.openssh.enable = true;

  services.networkmanager.enable = true;⁠
}
