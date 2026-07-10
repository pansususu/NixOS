{ config, pkgs, lib, ... }:

{
  options.virtualisation.libvirtd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable libvirt daemon.";
    };
  };

  config = lib.mkIf config.virtualisation.libvirtd.enable {
    environment.systemPackages = with pkgs; [ libvirt virt-manager ];

    users.groups.libvirtd = {
      gid = config.ids.gids.libvirtd;
    };

    finit.services.libvirtd = {
      description = "libvirt daemon";
      command = "${pkgs.libvirt}/bin/libvirtd -d";
      runlevels = "2345";
      conditions = [ "service/dbus/ready" ];
      user = "root";
      type = "forking";
      pid = "/run/libvirtd.pid";
    };
  };
}
