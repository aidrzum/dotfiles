# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-box"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.desktopManager.gnome-keyring.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aidr.shell = pkgs.zsh;
  users.users.aidr = {
    isNormalUser = true;
    description = "aidr";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" "libvirtd" "storage" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.firefox.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["aidr"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    adwaita-icon-theme
    alacritty
    bat
    brave
    brightnessctl
    btop
    cliphist
    cmake
    cmatrix
    copyq
    cowsay
    dbus
    dnsutils
    dunst
    dwt1-shell-color-scripts
    emacs-gtk
    exiftool
    eza
    fastfetch
    fd
    ffmpeg
    ffmpegthumbnailer
    fzf
    gcc
    git
    git
    gnome-extension-manager
    sushi
    gnome-tweaks
    grim
    hfsprogs
    htop
    hypridle
    hyprlock
    hyprpaper
    hyprprop
    hyprpolkitagent
    hyprshot
    imagemagick
    jq 
    kitty
    libnotify
    lolcat
    mesa-demos
    mpc
    mpd
    mpv
    ncdu
    ncmpcpp
    neovim
    networkmanagerapplet
    ntfs3g
    nmap 
    nwg-look
    ollama
    aichat
    pciutils
    pcmanfm
    playerctl
    poppler
    pulsemixer
    python314
    pw-volume
    p7zip
    qemu
    qt6ct
    radeontop
    ranger
    resvg
    ripgrep    
    rofi
    smbclient-ng
    slurp
    spice-gtk
    spice-vdagent
    spice
    sshfs
    swww
    terminator
    tmux
    tree
    tree
    unzip 
    usbutils
    vesktop
    vim
    virt-viewer
    vlc
    wallust
    wget
    wl-clipboard
    wlogout
    wofi
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    yazi
    zoxide
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.agave
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 
    22
    445
   ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
