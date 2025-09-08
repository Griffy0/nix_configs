{ pkgs, inputs, ... }:
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

  #stylix.targets.firefox.profileNames = [ "default" ];
  stylix = {
    targets = {
      vesktop.enable = false;
      firefox.enable = false;
      qt.enable = false;
    };
    cursor = {
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      name = "BreezX-RosePine-Linux";
      size = 20;
    };
  };
  programs.wofi.enable = true;
}
