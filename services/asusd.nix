{ config, pkgs, lib, ... }:

{
  options.services.asusd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable asusd (ASUS ROG daemon).";
    };
  };

  config = lib.mkIf config.services.asusd.enable {
    finit.services.asusd = {
      description = "ASUS ROG daemon";
      command = "${pkgs.asusctl}/bin/asusd";
      runlevels = "2345";
      conditions = [ "service/dbus/ready" ];
      user = "root";
      respawn = true;
    };
  };
}
