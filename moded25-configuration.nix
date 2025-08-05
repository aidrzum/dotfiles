{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nix-box-air"; # Define your hostname.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;  
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  users.users.l33tboi.shell = pkgs.fish;
  users.users.l33tboi = {
    isNormalUser = true;
    description = "l33tboi";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "video"];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;
  xdg.mime.enable = true;
  xdg.menus.enable = true;
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  environment.systemPackages = with pkgs; [
    wget
    vim
    ncdu
    figlet
    cmatrix
    htop
    btop
    neovim
    tree
    alacritty
    terminator
    ghostty
    fzf
    ripgrep    
    cmake
    gcc
    unzip 
    fastfetch
    tmux
    git
    nmap 
    lolcat 
    cowsay
    bat
    eza
    ranger
    rofi
    zsh
    dwt1-shell-color-scripts
    kitty
    vlc
    wofi
    hyprpaper
    swww
    copyq
    hyprshot
    dunst
    jq 
    grim
    slurp
    wl-clipboard
    libnotify
    mpd
    mpc
    ncmpcpp
    mpv
    xdg-utils
    adwaita-qt
    adwaita-qt6
    qt6ct
    dnsutils
    usbutils
    pciutils
    gvfs
    pcmanfm
    xdg-desktop-portal-hyprland
    hyprlock
    blueman
    networkmanagerapplet
    pw-volume
    pulsemixer
    hyprpolkitagent
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fantasque-sans-mono
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.kernelModules = [ "wl" ]; # set of kernel modules loaded in second stage of boot process
  boot.initrd.kernelModules = [ "kvm-intel" "wl" ]; # list of modules always loaded by the initrd
   nixpkgs.config.permittedInsecurePackages = [
   "broadcom-sta-6.30.223.271-57-6.12.40"
   ];
   zramSwap.enable = true;
   services.openssh.enable = true;
   networking.firewall.enable = false;
  system.stateVersion = "25.05"; # Did you read the comment?
}
