{ config, pkgs, inputs, ... }:

{
  # Basicos del Sistema 
  finit.runlevel = 3;

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    portals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  time.timeZone = "America/Asuncion";

  i18n.defaultLocale = "es_PY.UTF-8";
  hardware.console.keyMap = "la-latin1";

  programs.xorg = {
    enable = true;
    xkb.layout = "latam";
  };

  programs.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  programs.niri.enable = true;

  services.ly.enable = true;

  services.flatpak.enable = true;

  services.sysklogd.enable = true;

  services.nix-daemon.enable = true;

  services.nix-daemon.settings.experimental-features = [ "nix-command" "flakes" ];

  services.asusd.enable = true;

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
  
  # Paquetes
  environment.pathsToLink = [ "/share/applications" ];

  environment.systemPackages = with pkgs; [
    seatd
    pipewire
    wireplumber
    distroshelf
    distrobox
    vinegar
    vivaldi
    nano
    pkgs.dnsutils
    fortune
    wget
    helix
    obsidian
    alacritty
    git
    fastfetch
    btop
    spotify
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    bazaar
    qbittorrent
    brightnessctl
    virt-manager
    pavucontrol
    prismlauncher
    killall
    cowsay
    discord
    rofi
    playerctl
    vscode
    python3
    nixos-rebuild-ng
    iproute2
    iputils
    wev
    nautilus
    nwg-look
    papirus-icon-theme
    steam
    oreo-cursors-plus   
    xwayland-satellite
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

  # Browser
  environment.sessionVariables.BROWSER = "vivaldi"; 

  xdg.mime.defaultApplications = {
    "x-scheme-handler/http" = "vivaldi.desktop";
    "x-scheme-handler/https" = "vivaldi.desktop";
    "text/html" = "vivaldi.desktop";
  };

  # Variables de Entorno
  environment.etc."profile.d/finix-env.sh".text = ''
    export XCURSOR_SIZE=24
    export XCURSOR_THEME=oreo_spark_light_pink_cursors
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
    export ELECTRON_OZONE_PLATFORM_HINT=auto
    export LANG=es_PY.UTF-8
    export LOCALE_ARCHIVE=/run/current-system/sw/lib/locale/locale-archive
    export GTK_THEME=Adwaita:dark
    export XCURSOR_THEME=oreo_spark_light_pink_cursors
  '';

  # Aliases de Bash
  environment.etc."profile.d/aliases.sh".text = ''
    alias cdnix="cd /etc/nixos"
    alias ednix="sudo nano /etc/nixos/configuration.nix"
    alias edsystem="sudo nano /etc/nixos/modules/system.nix"
    alias edhardware="sudo nano /etc/nixos/modules/hardware.nix"
    alias ednetwork="sudo nano /etc/nixos/modules/networking.nix"
    alias edboot="sudo nano /etc/nixos/modules/boot.nix"
    alias edusers="sudo nano /etc/nixos/modules/users.nix"
    alias showsystem="sudo cat /etc/nixos/modules/system.nix"
    alias showhardware="sudo cat /etc/nixos/modules/hardware.nix"
    alias shownetwork="sudo cat /etc/nixos/modules/networking.nix"
    alias showboot="sudo cat /etc/nixos/modules/boot.nix"
    alias shownix="sudo cat /etc/nixos/configuration.nix"
    alias nixrebuild="sudo git -C /etc/nixos add . && sudo git -C /etc/nixos commit -m 'auto: update config' && sudo nixos-rebuild switch --flake /etc/nixos#finix"
    alias nixgen="nixos-rebuild list-generations"
    alias edflake="sudo nano /etc/nixos/flake.nix"
    alias showflake="sudo cat /etc/nixos/flake.nix"
    alias nixclean="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-store --gc && nixrebuild"
    alias eduser="sudo nano /etc/nixos/modules/users.nix"
    alias clean="clear"
  '';
}
