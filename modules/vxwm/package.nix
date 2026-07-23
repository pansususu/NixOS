{ lib, stdenv, xorg, fontconfig, freetype, pkg-config, configFile, modulesDefFile, src }:

stdenv.mkDerivation rec {
  pname = "vxwm";
  version = "2.3";
  inherit src;

  buildInputs = [
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    fontconfig
    freetype
  ];

  nativeBuildInputs = [ pkg-config ];

  preConfigure = ''
    cp ${configFile} config.def.h
    cp ${modulesDefFile} modules.def.h
  '';

  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "X11INC=${lib.getDev xorg.libX11}/include"
    "X11LIB=${lib.getLib xorg.libX11}/lib"
    "FREETYPEINC=${lib.getDev freetype}/include/freetype2"
  ];

  postInstall = ''
    cp ${src}/rvx $out/bin/rvx
    chmod +x $out/bin/rvx
  '';

  meta = with lib; {
    description = "Versatile X Window Manager - Enhanced dwm fork with infinite tags";
    homepage = "https://codeberg.org/wh1tepearl/vxwm";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
