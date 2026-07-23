{ config, pkgs, ... }:

{
  users.users.sabrina = {
    isNormalUser = true;
    initialPassword = "sabrina";
    extraGroups = [ "wheel" "audio" "video" "render" "input" "fuse" "libvirtd" "seat" ];
    packages = with pkgs; [ tree ];
  };

  programs.sudo.enable = true;
}
