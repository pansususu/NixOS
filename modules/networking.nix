{ config, pkgs, ... }:

{
  networking.hostName = "finix";
  services.iwd.enable = true;

  services.openssh.enable = true;

}
