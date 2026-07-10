{ config, pkgs, lib, ... }:

{
  options.services.ly-finit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Ly display manager under finit.";
    };
  };

  config = lib.mkIf config.services.ly-finit.enable {
    environment.systemPackages = [ pkgs.ly ];

      finit.services.ly = {
      description = "Ly Display Manager";
      
      command = "${pkgs.ly}/bin/ly";
      
      runlevels = "2345";
      
      user = "root";
    };
  };
}