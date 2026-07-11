{ config, pkgs, inputs, ... }:

{
  finit.runlevel = 3;

  services.dbus.enable = true;

  time.timeZone = "America/Asuncion";

  i18n.defaultLocale = "es_PY.UTF-8";
  hardware.console.keyMap = "la-latin1";

  programs.xorg = {
    enable = true;
    xkb.layout = "latam";
  };

  programs.pipewire.enable = true;

  services.ly.enable = true;
  services.niri.enable = true;

  services.flatpak.enable = true;

  services.sysklogd.enable = true;
  
  services.nix-daemon.enable = true;

  services.nix-daemon.settings.experimental-features = [ "nix-command" "flakes" ];

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

  environment.systemPackages = with pkgs; [
    seatd
    niri
    waybar
    pipewire
    distroshelf
    distrobox
    vinegar
    vivaldi
    pulseaudio
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
    asusctl
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    (runCommand "local-icons" {} ''
      mkdir -p $out/share/icons
      cp -r /home/sabrina/.icons/* $out/share/icons/ 2>/dev/null || true
    '')
  ];

  environment.etc."profile.d/finix-env.sh".text = ''
    export XCURSOR_SIZE=24
    export XCURSOR_THEME=oreo_black_cursors
    export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
    export ELECTRON_OZONE_PLATFORM_HINT=auto
    export LANG=es_PY.UTF-8
    export LOCALE_ARCHIVE=/run/current-system/sw/lib/locale/locale-archive
  '';

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
    alias nixrebuild="sudo nixos-rebuild switch --flake /etc/nixos#finix"
    alias nixgen="nixos-rebuild list-generations"
    alias edflake="sudo nano /etc/nixos/flake.nix"
    alias showflake="sudo cat /etc/nixos/flake.nix"
    alias nixclean="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-store --gc && nixrebuild"
    alias eduser="sudo nano /etc/nixos/modules/users.nix"
    alias clean="clear"
  '';

}
