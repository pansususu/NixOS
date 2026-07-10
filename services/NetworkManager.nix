{ config, pkgs, lib, ... }:

{
  options.networking.networkmanager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable NetworkManager daemon under finit.";
    };
  };

  config = lib.mkIf config.networking.networkmanager.enable {
    environment.systemPackages = with pkgs; [ networkmanager ];

    # NetworkManager requiere que dbus esté completamente listo para operar
    finit.services.networkmanager = {
      description = "NetworkManager daemon";
      command = "${pkgs.networkmanager}/bin/NetworkManager --no-daemon";
      runlevels = "2345";
      conditions = [ "service/dbus/ready" ];
      user = "root";
    };
  };
}
