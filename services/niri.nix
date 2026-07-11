{ config, pkgs, lib, ... }:

{
  options.services.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable niri Wayland compositor.";
    };
  };

  config = lib.mkIf config.services.niri.enable {
    environment.systemPackages = with pkgs; [ niri waybar ];

    environment.pathsToLink = [ "/share/wayland-sessions" ];
  };
}
