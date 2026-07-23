{ config, pkgs, inputs, ... }:

{
  time.timeZone = "America/Asuncion";

  i18n.defaultLocale = "es_PY.UTF-8";

  console.keyMap = "la-latin1";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.flatpak.enable = true;

  security.polkit.enable = true;

  services.asusd.enable = true;

  virtualisation.libvirtd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Spicetify
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    spotifyPackage = pkgs.spotify;
    theme = spicePkgs.themes.comfy;
    colorScheme = "Sakura";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
  };

  # Paquetes de sistema
  environment.pathsToLink = [ "/share/applications" ];

  environment.systemPackages = with pkgs; [
    seatd
    pipewire
    wireplumber
    nano
    pkgs.dnsutils
    fortune
    wget
    git
    nixos-rebuild-ng
    iproute2
    iputils
    killall
    wev
    asusctl
    steam
    distrobox
  ];

  # Fonts
  xdg.icons.enable = true;

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig.defaultFonts = {
    emoji = [ "Noto Color Emoji" ];
  };
}
