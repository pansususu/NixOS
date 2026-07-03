{ config, pkgs, ... }:

{
  users.users.sabrina = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "fuse" "libvirtd" ];
    packages = with pkgs; [ tree ];
  };
}
