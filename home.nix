{
  config,
  pkgs,
  lib,
  inputs,
  nixGL,
  ...
}: {
  nixGL = {
    packages = nixGL.packages; # you must set this or everything will be a noop
    defaultWrapper = "mesa"; # choose from nixGL options depending on GPU
  };

  home = {
    username = "$USER";
    homeDirectory = "/home/$USER";
    stateVersion = "25.11";
    packages = with pkgs; [
      (config.lib.nixGL.wrap alacritty)
    ];
  };

  programs.home-manager.enable = true;

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;
      };
    };
  };
}
