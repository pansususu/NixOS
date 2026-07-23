{ config, pkgs, ... }:

{
  programs.silentSDDM = {
    enable = true;
    theme = "default";
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "sabrina";
  };
}
