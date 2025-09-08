{ pkgs, ... }:
{
  home.packages = [
    pkgs.hyprpaper
  ];
  wayland.windowManager.hyprland = {
    enable = false;
    extraConfig = ''
      natural_scroll = true
    '';
  };
  programs.hyprpanel = {
    enable = true;
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ "/etc/nixos/modules/desktop_envs/hypr_wallpaper.png" ];
      wallpaper = [ "eDP-1,/etc/nixos/modules/desktop_envs/hypr_wallpaper.png" ];
    };
  };
  programs.hyprshot = {
    enable = true;
  };

#  programs.kitty = {
#    enable = true;
#    extraConfig = "background_opacity 0.6";
#  };
#  stylix.opacity.terminal = 0.4;
  #stylix.targets.firefox.profileNames = [ "default" ];
#  stylix.targets.vesktop.enable = false;
#  stylix.image = ./hypr_wallpaper.png;
  /*stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark";
    targets = {
      hyprland.enable = true;
      kitty.enable = true;
    };
  };*/  
# 4programs.hyprland.enable = true;
  programs.wofi.enable = true;
  #programs.kitty.enable = true;
}
