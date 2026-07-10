{ config, pkgs, ... }:

{
  users.users.sabrina = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "fuse" "libvirtd" "seat" ];
    packages = with pkgs; [ tree ];
    password = "$6$ywfdlQnGHBzBtuQQ$pi1ecG41kDmLFdLntK.QhehngzGwbtctdktkjHOMbmGTEWklpLcb5CdrYBROmj/MIfP7s76qr3hKM8sPCQ6zT.";
  };

  programs.sudo.enable = true;
}
