{ config, lib, pkgs, inputs, ... }: {
  imports = [ "${inputs.oxwm}/nixos/modules/services/x11/window-managers/oxwm.nix" ];
  services.xserver.windowManager.oxwm.enable = true;
}
