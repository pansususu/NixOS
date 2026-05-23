# ¡THIS IS A CONFIG FOR NVIDIA LAPTOP! (My laptop is ASUS TUF Gaming F15 FX506LH_FX506LH (1.0)

{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # Bootloader & System
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
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

  # User
  users.users.sabrina = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "fuse" ];
    packages = with pkgs; [ tree ];
  };

  # Software Unfree & Flatpak
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # Spicetiy
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
    nano
    wget
    alacritty
    firefox
    git
    fastfetch
    discord
    btop
    spotify
    asusctl
  ];

  # Enviroment Variables
   environment.sessionVariables = {
  XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
    "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  # Programs (Steam,MTR, ...)
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
      fuse
      libglvnd
      libxkbcommon
      zlib
      stdenv.cc.cc
      icu
      openssl
    ];
  };

  programs.fuse.userAllowOther = true;

  # Nvidia & Asus
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # Owner Driver
    powerManagement.enable = false; # Change to true if you have problems to poweroff/sleep
  };

  hardware.nvidia.prime = {
  offload = {
    enable = true;
    enableOffloadCmd = true;
  };
  intelBusId = "PCI:0:2:0";
  nvidiaBusId = "PCI:1:0:0";
};

  hardware.xpadneo.enable = true;
  hardware.enableRedistributableFirmware = true;

  services.asusd.enable = true;

  # Zram
   zramSwap = {
  enable = true;
  memoryPercent = 50;
};

  # DE (Kde Plasma 6)
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # SSH
  services.openssh.enable = true;
  
  # Flake 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; 
}
