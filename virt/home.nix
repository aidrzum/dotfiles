{config, pkgs, ...}:

let
  
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
    rofi = "rofi";
  };
in 

{
    home.username = "l33tnix";
    home.homeDirectory = "/home/l33tnix";
    programs.git.enable = true;
    home.stateVersion = "25.05";
    programs.zsh = {
        enable = true;
        shellAliases = {
            xx = "exit";
            edit = "sudo -e";
            update = "sudo nixos-rebuild switch /home/l33tnix/nixos-dotfiles#nixos-vbox";
            neo = "fastfetch";
            l = "eza --icons";
            ll = "eza --icons -l";
            zz = "exec zsh";
            ttmx = "tmux new -s N || tmux attach -t N";
            tmx = "tmux new -s N2 || tmux attach -t N2";
            yy = "yazi";
        };
        history.size = 10000;
        oh-my-zsh = {
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


    xdg.configFile = builtins.mapAttrs
      (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
      })
      configs;

#    xdg.configFile."qtile" = {
#      source = create_symlink "${dotfiles}/qtile/";
#      recursive = true;
#    };
#    
#    xdg.configFile."nvim" = {
#      source = create_symlink "${dotfiles}/nvim/";
#      recursive = true;
#    };
#    xdg.configFile."alacritty" = {
#      source = create_symlink "${dotfiles}/alacritty/";
#      recursive = true;
#    };

    home.packages = with pkgs; [

      btop
      eza
      fastfetch
      fd
      fzf
      gcc
      htop
      ncdu
      neovim
      nil
      nitrogen
      nixpkgs-fmt
      nodejs
      poppler
      qutebrowser
      ripgrep
      rofi
      smbclient-ng
      tmux
      yazi
      zoxide
      zsh-autosuggestions
      zsh-syntax-highlighting
    ];
}
