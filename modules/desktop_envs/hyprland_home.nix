{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = false;
    extraConfig = ''
      natural_scroll = true
    '';
  };
  programs.waybar = {
    enable = true;
  };
  services.hyprpaper = {
    enable = true;
  };
  programs.hyprshot = {
    enable = true;
  };
  #stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.vesktop.enable = false;
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
