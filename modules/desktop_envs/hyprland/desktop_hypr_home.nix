{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ "/etc/nixos/modules/desktop_envs/hyprland/hypr_wallpaper.png" ];
      wallpaper = [ 
        "DP-2,/etc/nixos/modules/desktop_envs/hyprland/hypr_wallpaper.png" 
        "DP-3,/etc/nixos/modules/desktop_envs/hyprland/hypr_wallpaper.png"
      ];
    };
  };
}
