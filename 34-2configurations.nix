{ config, pkgs, ... }:
{
  imports =
    [
    ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nix-box"; # Define your hostname.
    networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kathmandu";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.power-profiles-daemon.enable = true;
  services.gvfs.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.thermald.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    vaapiIntel
      intel-media-driver
  ];
  users.users.aidr.shell = pkgs.zsh;
  users.users.aidr = {
    isNormalUser = true;
    description = "aidr";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" "libvirtd" "storage" ];
    packages = with pkgs; [
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      la = "ls -al";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
      neo = "fastfetch";
      l = "eza --icons";
      ll = "eza --icons -l";
      ttmx = "tmux new -s N || tmux attach -t N";
      xx = "exit";
      nse = "sudo vim /etc/nixos/confiurations.nix";
      nsr = "sudo nix-collect-garbage -d";
      zz = "exec zsh";
      yy = "yazi";
      neof="neo -c ~/.config/fastfetch/config-compact.jsonc";
      UP = "python3 -m http.server 8181";
    };
    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
          "z"
          "emoji"
          "emotty"
      ];
      theme = "random";
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "source" = "./colors.conf";
      monitor = ",preferred,auto,auto";
      exec-once = [ 
        "waybar"
        "swww-daemon"
        "hyprpaper"
        "hypridle"
        "copyq --start-server"
        "mpd"
        "swaync"
        "blueman-applet & nm-applet"
        "systemctl --user start hyprpolkitagent"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP "
        "gnome-keyring-daemon"
        "emacs --daemon "
        "[workspace special:kitty silent] kitty"
        "[workspace special:yazi silent] yazi"
        "[workspace special:emacs silent] ~/Documents/emaccy"
        "$terminal"
      ];
        "$terminal" = "kitty"
        "$fileManager" = "nautilus"
        "$menu" = "wofi --show drun"
        env = [ 
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "AQ_DRM_DEVICES=,/dev/dri/card1:/dev/dri/card2"
        ];
      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "$source_color $on_secondary 45deg";
        "col.inactive_border" = "$scrim";
        resize_on_border = true;
        allow_tearing = false;
        layout = dwindle;
      };
      decoration = {
        rounding = 15;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = rgba(1a1a1aee);
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.2696;
        };
      };
      animations = {
        enabled = "yes, please :)";
      };
      bezier = [ 
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];
      animation = [ 
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, slidefadevert -50%"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
        "specialWorkspace, 1, 5, easeInOutCubic, slidefadevert -50%"
      ];
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = master;
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = us;
        kb_variant =;
        kb_model =;
        kb_options =;
        kb_rules =;
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 50;
        repeat_delay = 500;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_distance = 300;
      };
      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
        pass_mouse_when_bound = false;
      };
      device = {
        name = epic-mouse-v1;
        sensitivity = -0.5;
      };
      "$mainMod" = "SUPER";
      "$mainMod2" = "alt";
        bind = [ 
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, w, exec, $terminal"
        "$mainMod ALT, RETURN, exec, terminator"
        "$mainMod SHIFT,RETURN, exec, $fileManager"
        "$mainMod, q, killactive,"
        "$mainMod SHIFT, q, exit,"
        "$mainMod, e, exec, nautilus  # Custom from filemanager to explorer ;)"
        "$mainMod, c, exec, qutebrowser  # Custom from filemanager to explorer ;)"
        "$mainMod SHIFT, B, exec, brave --enable-features=UseOzonePlatform --ozone-platform=wayland"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod SHIFT, e, exec, /home/aidr/Documents/emaccy"
        "$mainMod ctrl, v, exec, /home/aidr/Documents/virty"
        "$mainMod SHIFT, p, exec, hyprshot -m region"
        "ALT, C, exec, wl-paste --primary | wl-copy"
        "ALT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "ALT SHIFT, V, exec, copyq show"
        "ALT SHIFT, L, exec, hyprlock"
        "SUPER, Tab, workspace, previous"
        "ALT, Tab, cyclenext"
        "ALT SHIFT, Tab, cyclenext, prev"
        "$mainMod, period, workspace, +1"
        "$mainMod, comma, workspace, -1"
        "ALT, n, exec, swaync-client -t -sw"
        "ALT, k, togglespecialworkspace, kitty"
        "ALT, j, togglespecialworkspace, ~/Documents/emaccy"
        "ALT, y, togglespecialworkspace, yazi"
        "ALT, b, togglespecialworkspace, subl"
        "ALT SHIFT, Q, exec, terminator -e ncmpcpp"
        "ALT SHIFT, RETURN, exec, mpc play"
        "ALT SHIFT, down, exec, mpc stop"
        "ALT SHIFT, left, exec, mpc prev"
        "ALT SHIFT, right, exec, mpc next"
        "ALT SHIFT, up, exec, mpc pause"
        "$mainMod SHIFT, R,submap,resize"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        ", code:238, exec, brightnessctl -d smc::kbd_backlight s +10"
        ", code:237, exec, brightnessctl -d smc::kbd_backlight s 10-"
        ];
      binde = [ 
        "$mainMod ALT, right, resizeactive, 30 0"
        "$mainMod ALT, left, resizeactive, -30 0"
        "$mainMod ALT, up, resizeactive, 0 -30"
        "$mainMod ALT, down, resizeactive, 0 30"
        "$mainMod ALT, L, resizeactive, 30 0"
        "$mainMod ALT, H, resizeactive, -30 0"
        "$mainMod ALT, K, resizeactive, 0 -30"
        "$mainMod ALT, J, resizeactive, 0 30"
        "$mainMod SHIFT, right, moveactive, 30 0"
        "$mainMod SHIFT, left, moveactive, -30 0"
        "$mainMod SHIFT, up, moveactive, 0 -30"
        "$mainMod SHIFT, down, moveactive, 0 30"
        "$mainMod SHIFT, L, moveactive, 30 0"
        "$mainMod SHIFT, H, moveactive, -30 0"
        "$mainMod SHIFT, K, moveactive, 0 -30"
        "$mainMod SHIFT, J, moveactive, 0 30"
      ];
      bindm = [ 
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [ 
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
      bindl = [ 
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      windowrule = [ 
        "float,class:^(terminator)$"
        "float,class:^(Alacritty)$,title:^(Alacritty)$"
        "float,class:^(.blueman-manager-wrapped)$"
        "float,class:^(org.gnome.NautilusPreviewer)$"
        "float,class:^(com.github.hluk.copyq)$"
        "float,class:^(vlc)$"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
      layerrule = [ 
        "blur,rofi"
        "blur,wofi"
        "blur,conky"
        "blur,kitty"
        "blur,terminator"
      ];
    };
  };

  programs = {
    waybar.enable = true;
    firefox.enable = true;
    virt-manager.enable = true;
  };
  users.groups.libvirtd.members = ["aidr"];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      adwaita-icon-theme
      adwaita-qt
      adwaita-qt6
      ags_1
      aichat
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
      flat-remix-gtk
      flat-remix-icon-theme
      fzf
      gcc
      git
      gnome-extension-manager
      gnome-menus
      gnome-tweaks
      grim
      hfsprogs
      htop
      hypridle
      hyprlock
      hyprnotify
      hyprpaper
      hyprpolkitagent
      hyprprop
      hyprshot
      imagemagick
      jq 
      kitty
      libnotify
      lolcat
      matugen
      mesa-demos
      mpc
      mpd
      mpv
      nautilus
      nautilus-open-any-terminal
      ncdu
      ncmpcpp
      neovim
      networkmanagerapplet
      nmap 
      ntfs3g
      nwg-look
      ollama
      p7zip
      pciutils
      pcmanfm
      playerctl
      pokemon-colorscripts-mac
      poppler
      power-profiles-daemon
      pulsemixer
      pw-volume
      python314
      pywalfox-native
      qemu
      qt6ct
      qutebrowser
      radeontop
      ranger
      resvg
      ripgrep    
      rofi
      slurp
      smbclient-ng
      spice
      spice-gtk
      spice-vdagent
      sshfs
      sublime3
      sushi
      swaynotificationcenter
      swww
      terminator
      tmux
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
      yaru-remix-theme
      yazi
      zoxide
      zsh-autosuggestions
      zsh-syntax-highlighting
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.agave
  ];
# programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh = {
    enable = true;
    ports = [ 6667 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "aidr" ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 
    6667
    445
  ];
  networking.firewall.enable = true;
  system.stateVersion = "25.05";
}
