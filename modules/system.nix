{ config, pkgs, inputs, ... }:

{
  time.timeZone = "America/Asuncion";

  # Language & Console
  i18n.defaultLocale = "es_PY.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "la-latin1";
  };
 
  # Sound 
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;

  # Software Unfree & Flatpak
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # Spicetify (Nota: necesita 'inputs' arriba para heredar la flake)
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    spotifyPackage = pkgs.spotify; 
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    nano fortune wget waybar kitty firefox git fastfetch btop spotify asusctl
    bazaar rofi qbittorrent nemo grim slurp wl-clipboard awww hyprshot
    brightnessctl nwg-look virt-manager pavucontrol prismlauncher cowsay
    discord playerctl
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

  # Cursors & Session Variables
  environment.variables = {
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "oreo_pink_cursors"; 
  };

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
    WLR_NO_HARDWARE_CURSORS = "1"; 
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # Programs (Steam, MTR, Nix-LD, etc)
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      fuse libglvnd libxkbcommon zlib stdenv.cc.cc icu openssl
    ];
  };

  programs.fuse.userAllowOther = true;

  # Alias Bash
  programs.bash.shellAliases = {
    cdnix = "cd /etc/nixos";
    ednix = "sudo nano /etc/nixos/configuration.nix";
    shownix = "sudo cat /etc/nixos/configuration.nix";
    edhypr = "nano ~/.config/hypr/hyprland.lua";
    showhypr = "cat ~/.config/hypr/hyprland.lua";
    nixrebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    nixgen = "nixos-rebuild list-generations";
    edflake = "sudo nano /etc/nixos/flake.nix";
    showflake = "sudo cat /etc/nixos/flake.nix";
    nixclean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2 && sudo nix-store --gc && nixrebuild";
  };

  # Greeter / Login Manager 
  services.displayManager.ly = {
    enable = true;
    settings.animation = 1;
  };

  # WM & DEs
  programs.hyprland.enable = true;

  programs.singularity-desktop = {
    enable = true;
    greeter.enable = false;
  };

  # Portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;
}
