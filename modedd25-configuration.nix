{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nix-box-air"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;
  # Enable Bluetooth Custom 
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;  
  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";
  # Select internationalisation properties.
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
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  #security.polkit.enable =- true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.l33tboi.shell = pkgs.fish;
  users.users.l33tboi = {
    isNormalUser = true;
    description = "l33tboi";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "video"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  # Install firefox.
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.fish.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  xdg.mime.enable = true;
  xdg.menus.enable = true;
 # Fix for empty "Open With" menu in Dolphin when running under Hyprland
 # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    cliphist
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
    xdg-desktop-portal-gtk
    hyprlock
    blueman
    networkmanagerapplet
    pw-volume
    pulsemixer
    hyprpolkitagent
    brightnessctl
    playerctl
    wlogout
    hypridle
    dbus
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fantasque-sans-mono
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
 # nixpkgs.config.allowUnfree = true; # proprietary drivers
  boot.kernelModules = [ "wl" ]; # set of kernel modules loaded in second stage of boot process
  boot.initrd.kernelModules = [ "kvm-intel" "wl" ]; # list of modules always loaded by the initrd
   nixpkgs.config.permittedInsecurePackages = [
   "broadcom-sta-6.30.223.271-57-6.12.40"
   ];
   zramSwap.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:
  #Custom Services:
   #services.mpd = {
   #enable = true;
   #musicDirectory = "/home/l33tboi/Music";  # Replace with your actual music directory
   #extraConfig = ''
   #  bind_to_address "~/.config/mpd/socket";  # Use UNIX socket
   #'';
   #};
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
