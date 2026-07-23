{ config, pkgs, inputs, ... }:

{
  home.username = "sabrina";
  home.homeDirectory = "/home/sabrina";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    vivaldi
    alacritty 
    obsidian 
    vscode
    discord
    qbittorrent
    prismlauncher 
    nautilus 
    micro 
    opencode
    fastfetch
    btop
    rofi
    feh
    slock
    maim
    xdotool
    playerctl 
    brightnessctl
    pavucontrol 
    virt-manager 
    nwg-look 
    xwayland-satellite
    python3 
    bazaar 
    cowsay
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    papirus-icon-theme
    oreo-cursors-plus
    vinegar
  ];

  xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;
  xdg.configFile."niri/noctalia.kdl".source = ./niri-noctalia.kdl;

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      . /etc/bashrc
    '';
    shellAliases = {
      cdnix      = "cd /etc/nixos";
      ednix      = "sudo nano /etc/nixos/configuration.nix";
      edsystem   = "sudo nano /etc/nixos/modules/system.nix";
      edhardware = "sudo nano /etc/nixos/modules/hardware.nix";
      ednetwork  = "sudo nano /etc/nixos/modules/networking.nix";
      edboot     = "sudo nano /etc/nixos/modules/boot.nix";
      edusers    = "sudo nano /etc/nixos/modules/users.nix";
      eduser     = "sudo nano /etc/nixos/modules/users.nix";
      edflake    = "sudo nano /etc/nixos/flake.nix";
      edhome     = "sudo nano /etc/nixos/modules/home.nix";
      showsystem = "sudo cat /etc/nixos/modules/system.nix";
      showhardware = "sudo cat /etc/nixos/modules/hardware.nix";
      shownetwork  = "sudo cat /etc/nixos/modules/networking.nix";
      showboot     = "sudo cat /etc/nixos/modules/boot.nix";
      shownix      = "sudo cat /etc/nixos/configuration.nix";
      showflake    = "sudo cat /etc/nixos/flake.nix";
      nixrebuild   = "sudo git -C /etc/nixos add . && sudo git -C /etc/nixos commit -m 'auto: update config' && sudo nixos-rebuild switch --flake /etc/nixos#finix";
      nixgen       = "nixos-rebuild list-generations";
      nixclean     = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-store --gc && nixrebuild";
      clean        = "clear";
      showniri     = "cat /etc/nixos/modules/niri-config.kdl";
      edniri       = "sudo nano /etc/nixos/modules/niri-config.kdl";
      shownoctalia = "cat /etc/nixos/modules/niri-noctalia.kdl";
      ednoctalia   = "sudo nano /etc/nixos/modules/niri-noctalia.kdl";
    };
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "web-search" "colorize" ];
    };
    initContent = ''
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' formats ' %F{86}[%F{81}%b%F{86}]%f'
      zstyle ':vcs_info:git:*' actionformats ' %F{86}[%F{208}%b|%a%F{86}]%f'
      PROMPT='%F{81}%n%F{117}@%F{86}%m%F{81}:%F{117}%~%F{86}''${vcs_info_msg_0_}%F{81}%(#.#.❯)%f '
    '';
    shellAliases = {
      cdnix      = "cd /etc/nixos";
      ednix      = "sudo nano /etc/nixos/configuration.nix";
      edsystem   = "sudo nano /etc/nixos/modules/system.nix";
      edhardware = "sudo nano /etc/nixos/modules/hardware.nix";
      ednetwork  = "sudo nano /etc/nixos/modules/networking.nix";
      edboot     = "sudo nano /etc/nixos/modules/boot.nix";
      edusers    = "sudo nano /etc/nixos/modules/users.nix";
      eduser     = "sudo nano /etc/nixos/modules/users.nix";
      edflake    = "sudo nano /etc/nixos/flake.nix";
      edhome     = "sudo nano /etc/nixos/modules/home.nix";
      showhome   = "sido cat /etc/nixos/modules/home.nix";
      showsystem = "sudo cat /etc/nixos/modules/system.nix";
      showhardware = "sudo cat /etc/nixos/modules/hardware.nix";
      shownetwork  = "sudo cat /etc/nixos/modules/networking.nix";
      showboot     = "sudo cat /etc/nixos/modules/boot.nix";
      shownix      = "sudo cat /etc/nixos/configuration.nix";
      showflake    = "sudo cat /etc/nixos/flake.nix";
      nixrebuild   = "sudo git -C /etc/nixos add . && sudo git -C /etc/nixos commit -m 'auto: update config' && sudo nixos-rebuild switch --flake /etc/nixos#finix";
      nixgen       = "nixos-rebuild list-generations";
      nixclean     = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5 && sudo nix-store --gc && nixrebuild";
      clean        = "clear";
      showniri     = "cat /etc/nixos/modules/niri-config.kdl";
      edniri       = "sudo nano /etc/nixos/modules/niri-config.kdl";
      shownoctalia = "cat /etc/nixos/modules/niri-noctalia.kdl";
      ednoctalia   = "sudo nano /etc/nixos/modules/niri-noctalia.kdl";
    };
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "32";
    XCURSOR_THEME = "oreo_spark_blue_cursors";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GTK_THEME = "Adwaita:dark";
    BROWSER = "vivaldi";
  };

  xdg.mime.enable = true;

  xresources.properties = {
    "Xcursor.theme" = "oreo_spark_blue_cursors";
    "Xcursor.size" = 32;
  };
}
