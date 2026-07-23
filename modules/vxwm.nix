{ config, lib, pkgs, inputs, ... }:

let
  vxwm = pkgs.callPackage ./vxwm/package.nix {
    src = inputs.vxwm-src;
    configFile = ./vxwm/config.h;
    modulesDefFile = ./vxwm/modules.def.h;
  };
in
{
  environment.systemPackages = [ vxwm ];

  services.xserver.windowManager.session = [{
    name = "vxwm";
    start = ''
      ${vxwm}/bin/vxwm
    '';
  }];
}
