{ config, lib, pkgs, inputs, ... }:
let
  oxwm = pkgs.callPackage "${inputs.oxwm}/default.nix" {
    gitRev = inputs.oxwm.rev or inputs.oxwm.shortRev or "unknown";
  };
in {
  environment.systemPackages = [ oxwm ];

  services.xserver.windowManager.session = [{
    name = "oxwm";
    start = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      ${oxwm}/bin/oxwm &
      waitPID=$!
    '';
  }];
}
